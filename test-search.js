const { GoogleGenerativeAI } = require('@google/generative-ai');

// ضع مفتاحك الجديد هنا للتأكد منه
const genAI = new GoogleGenerativeAI('AIzaSyC9QilQdZFejEYv3DNylXkGnkWOxevQL4Q');

async function listModels() {
  try {
    console.log("--- جاري جلب قائمة الموديلات المتاحة لمفتاحك ---");
    
    // استخدام الدالة المدمجة لجلب الموديلات
    // ملاحظة: في النسخ الحديثة يتم جلبها عبر الـ GenerativeAI client
    const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models?key=${genAI.apiKey}`);
    const data = await response.json();

    if (data.models) {
      console.table(data.models.map(m => ({
        Name: m.name,
        DisplayName: m.displayName,
        Capabilities: m.supportedGenerationMethods.join(', ')
      })));
      
      console.log("\n✅ ابحث عن موديلات الـ 'embedContent' عشان تستخدمها في الـ Vectors.");
    } else {
      console.error("❌ لم يتم العثور على موديلات. تأكد من صحة الـ API Key.");
      console.log(data);
    }
  } catch (error) {
    console.error("❌ حدث خطأ أثناء الاتصال:", error.message);
  }
}

listModels();