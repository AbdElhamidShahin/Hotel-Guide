const { createClient } = require('@supabase/supabase-js');
const { GoogleGenerativeAI } = require('@google/generative-ai');

const supabase = createClient('https://oavjmvbwyrkixfnlzmcg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hdmptdmJ3eXJraXhmbmx6bWNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4NzY4MDMsImV4cCI6MjA3ODQ1MjgwM30.AssSZLJLLC7X_DmkynMhkjy1Hrq--A82pol5YvE5wbs');
const genAI = new GoogleGenerativeAI('AIzaSyC9QilQdZFejEYv3DNylXkGnkWOxevQL4Q');

async function generateEmbeddings() {
  const { data: hotels, error } = await supabase
    .from('hotels')
    .select('id, description, amenities, category, location, views, price_starts_from')
    .is('embedding', null);

  if (error) {
    console.error('❌ خطأ في جلب البيانات:', error.message);
    return;
  }

  if (hotels.length === 0) {
    console.log('✅ كل الفنادق معالجة بالفعل.');
    return;
  }

  console.log(`🚀 جاري معالجة ${hotels.length} فندق...`);
  const model = genAI.getGenerativeModel({ model: "gemini-embedding-001" });

  const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

  for (const hotel of hotels) {
    try {
      const fullInfo = `
        Description: ${hotel.description || ''}
        Category: ${hotel.category || ''}
        Location: ${hotel.location || ''}
        Amenities: ${hotel.amenities || ''}
        Views: ${hotel.views || ''}
        Price starts from: ${hotel.price_starts_from || ''}
      `;

      // ✅ نداء واحد فقط للموديل (أنت كنت حاطط سطرين)
      const result = await model.embedContent(fullInfo);
      const embedding = result.embedding.values;

      console.log(`📍 تم توليد Vector للفندق: ${hotel.id}`);

      // تحديث قاعدة البيانات
      const { error: updateErr } = await supabase
        .from('hotels')
        .update({ embedding: embedding })
        .eq('id', hotel.id);

      if (updateErr) {
        console.error(`❌ فشل تحديث الفندق ${hotel.id}:`, updateErr.message);
      } else {
        console.log(`✅ تم تحديث الفندق ${hotel.id} بنجاح.`);
      }

      // ⏳ انتظر 3 ثواني قبل الفندق اللي بعده عشان الأمان
      // الخطة المجانية بتسمح بـ 15 طلب في الدقيقة لـ Embeddings
      await delay(4000);

    } catch (err) {
      console.error(`❌ خطأ في الفندق ${hotel.id}:`, err.message);
      // لو حصل خطأ "Quota" استنى فترة أطول شوية
      if (err.message.includes('429')) {
        console.log('⏳ استهلاك عالي.. هنريح 30 ثانية ونكمل...');
        await delay(30000);
      }
    }
  }
  console.log('✨ المهمة انتهت!');
}

generateEmbeddings();