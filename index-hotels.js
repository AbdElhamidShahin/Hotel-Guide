const { createClient } = require('@supabase/supabase-js');
const { GoogleGenerativeAI } = require('@google/generative-ai');

const supabase = createClient('https://oavjmvbwyrkixfnlzmcg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hdmptdmJ3eXJraXhmbmx6bWNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4NzY4MDMsImV4cCI6MjA3ODQ1MjgwM30.AssSZLJLLC7X_DmkynMhkjy1Hrq--A82pol5YvE5wbs');
const genAI = new GoogleGenerativeAI('AIzaSyCIW8w3_enqGg5UdWwnHAwr9Q9Looj0sNk');

async function generateEmbeddings() {
  const { data: hotels, error } = await supabase
    .from('hotels')
    .select('id, description, amenities, category, location, views, price_starts_from')
    .is('embedding', null);

  if (error) {
    console.error('❌ خطأ في جلب البيانات من Supabase:', error.message);
    return;
  }

  if (hotels.length === 0) {
    console.log('✅ لا توجد فنادق تحتاج لمعالجة (كل الحقول ممتلئة).');
    return;
  }

  console.log(`🚀 وجدنا ${hotels.length} فندق محتاجين معالجة...`);
  const model = genAI.getGenerativeModel({ model: "gemini-embedding-001" });

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

      // 1. توليد الـ Vector
      const result = await model.embedContent(fullInfo);
      const embedding = result.embedding.values;

      console.log(`📍 معالجة الفندق: ${hotel.id} | طول الـ Vector: ${embedding.length}`);

      // 2. التحديث في الداتابيز مع استخدام select للتأكد
      const { data: updatedData, error: updateErr } = await supabase
        .from('hotels')
        .update({ embedding: embedding })
        .eq('id', hotel.id)
        .select();

      if (updateErr) {
        console.error(`❌ فشل التحديث في Supabase للفندق ${hotel.id}:`, updateErr.message);
      } else if (updatedData && updatedData.length > 0) {
        console.log(`✅ تم التحديث بنجاح! الفندق ${hotel.id} لم يعد NULL.`);
      } else {
        console.log(`⚠️ تحذير: لم يتم العثور على الصف لتحديثه للفندق ${hotel.id}.`);
      }

    } catch (err) {
      console.error(`❌ خطأ عام أثناء معالجة الفندق ${hotel.id}:`, err.message);
    }
  }
  console.log('✨ انتهت المهمة بنجاح!');
}

generateEmbeddings();