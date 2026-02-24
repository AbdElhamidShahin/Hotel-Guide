const { createClient } = require('@supabase/supabase-js');
const { GoogleGenerativeAI } = require('@google/generative-ai');

// إعدادات الربط
const supabase = createClient('https://oavjmvbwyrkixfnlzmcg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hdmptdmJ3eXJraXhmbmx6bWNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4NzY4MDMsImV4cCI6MjA3ODQ1MjgwM30.AssSZLJLLC7X_DmkynMhkjy1Hrq--A82pol5YvE5wbs');
const genAI = new GoogleGenerativeAI('AIzaSyCIW8w3_enqGg5UdWwnHAwr9Q9Looj0sNk');

async function searchHotels(userQuery) {
    try {
        // استخدمنا 004 عشان نضمن مقاس 3072 المتخزن في الداتابيز
  const model = genAI.getGenerativeModel({ model: "gemini-embedding-001" });

        console.log(`🚀 جاري البحث عن: "${userQuery}"...`);

        // 1. تحويل جملة المستخدم لـ Vector
        const result = await model.embedContent(userQuery);
        const userVector = result.embedding.values;

        // 2. مناداة الـ Function اللي عملناها في Supabase (RPC)
        const { data: results, error } = await supabase.rpc('match_hotels', {
            query_embedding: userVector,
            match_threshold: 0.1, // قللت الرقم عشان يظهر نتائج أكتر في التجربة
            match_count: 5       // يرجع أفضل 5 نتائج
        });

        if (error) throw error;

        if (!results || results.length === 0) {
            console.log("p لم يتم العثور على نتائج تشبه هذا الوصف.");
            return;
        }

        console.log(`\n✅ تم العثور على ${results.length} نتائج مرتبة حسب الأقرب للمعنى:`);
        console.log("---------------------------------------------------------");


        if (!results || results.length === 0) {
            console.log("⚠️ لم يتم العثور على نتائج تشبه هذا الوصف. جرب تقليل الـ match_threshold لـ 0.2");
            return;
        }

        console.log(`\n✅ تم العثور على ${results.length} فنادق:`);
        results.forEach((hotel, i) => {
            console.log(`${i + 1}. الفندق: ${hotel.name}`);
            console.log(`   نسبة التشابه: ${(hotel.similarity * 100).toFixed(1)}%`);
            console.log(`   العنوان: ${hotel.address || hotel.location}`);
            console.log(`   السعر يبدأ من: ${hotel.price_starts_from}`);
            console.log("---------------------------------------------------------");
        });

    } catch (err) {
        console.error("❌ خطأ أثناء عملية البحث:", err.message);
    }
}

// ابحث هنا عن أي حاجة! جرب "مكان رومانسي" أو "فندق للعائلات" أو "قريب من البحر"
searchHotels("عايز فندق هادي ومناسب للعرسان وسعره مش غالي");