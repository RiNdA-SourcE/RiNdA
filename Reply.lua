local function Reply(msg)
local text = msg.content_.text_
if not database:get(bot_id..'Reply:Status'..msg.chat_id_) then
if text == 'هلو' then
TextReply = 'هـلا كـګـو شـونـك..🦖'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'شلونكم' then
TextReply = 'عـايشـين ونعـمه الله تحيـط بينه وانتـه..🍧'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'شلونك' then
TextReply = 'الحمـدالله يعـافيتي وانته..🥤'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'تمام' then
TextReply = 'دوم بـࢪو..🦄'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'هلاو' then
TextReply = 'هلـوات يحـلوو..🎀'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == '😐' then
TextReply = 'كـافي دࢪ࣪ ايـموجي تافـه..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'هاي' then
TextReply = 'هـاي لو ذيـج ههاي ضحـكه بلانكلز..🦖'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'اريد اكبل' then
TextReply = 'كـبل لو صـواب سـرسح لا دجـك بطـل..🎀'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'لتزحف' then
TextReply = 'شعـليك بـي هوه انتـه من جـوا لجـوا تشتـغل..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'كلخرا' then
TextReply = 'نـجب اتبسـوز..🥤'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'زاحف' then
TextReply = 'اك لـيش مغثـوث..🦇'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'دي' then
TextReply = 'دكـافي عـود شخصـيه من تغلـط وانته فيطي..🍷'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'فرخ' then
TextReply = 'شـنو حاصـرك قبـل..🍦'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'تعالي خاص' then
TextReply = 'نـصيحه من وائـل دكلها ناعـم لو اشتغلـه..🦖'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'اكرهك' then
TextReply = 'دمـشي قنفـذ عسـاس ساحل نفسي عليـلك..🦄'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'احبك' then
TextReply = 'اسـف ماكـدر اخـون وائل ابـتعد..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'باي' then
TextReply = 'بـعد وقت تع اطقك طا طا طا ..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'عوائل' then
TextReply = 'نـجب طع طع طع ..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'صايره عوائل' then
TextReply = 'دنـجب عـود تمبلر وانتـه رب معيـدي..🎀'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'واكف' then
TextReply = 'اتحداڪ وانته واڪف تخلي لسانڪ يطڪ خشمڪ..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'وين المدير' then
TextReply = 'شࢪايود تفضل شࢪايود..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'انجب' then
TextReply = 'ويـن..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'تحبني' then
TextReply = 'اذا وجـهڪ ينطلـ؏ بي ف يب..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'مطور السورس' then
TextReply = '↯𝗗𝗲𝘃 𝗡𝗮𝗺𝗲↶ @WYYYYY ↷ @Biiiii'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == '🙄' then
TextReply = 'نزل عينك حبيہَ'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'مطور سورس' then
TextReply = '↯𝗗𝗲𝘃 𝗡𝗮𝗺𝗲↶ @WYYYYY ↷ @Biiiii'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == '😳' then
TextReply = 'ها بس لا شفت عمتك العوبه'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == '🙁' then
TextReply = 'تعال شكيلي اهمومك ليش ضايج حياتي'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == '🚶💔' then
TextReply = 'وين رايح تعال حبيہَ'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == '🙂' then
TextReply = 'ثكيل مطي'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'تافه' then
TextReply = 'تافهه لو بࢪتقال..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'صباحو' then
TextReply = 'منوࢪني يا وࢪده صباح الڪيڪ..🥤'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'صباح الخير' then
TextReply = 'هلا بـࢪو صباح النوࢪ يڪيڪ..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'كفو' then
TextReply = 'علـࢪاسي علࢪاسي..🥤'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'تافهه' then
TextReply = 'تافهه لو بࢪتقاله اضحڪ تفف..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'اها' then
TextReply = 'اي لعـد شعبالڪ..🦇'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'شسمج' then
TextReply = 'ࢪشوان الجاده وانته..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'شسمك' then
TextReply = 'جبـاࢪ ڪوستࢪ..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'شوف' then
TextReply = 'ششوف حبيہَ'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'مساء الخير' then
TextReply = 'مساء الياسمين'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'المدرسه' then
TextReply = 'لاجيب اسمها لاسطرك'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'منو ديحذف رسائلي' then
TextReply = 'منشئ كروب يحذفها حبيہَ'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'البوت واكف' then
TextReply = 'ولبـاس حمـزه شغـال..🥤'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'غلس' then
TextReply = 'دنـجب شغـلس اخت العـميه'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'حارة' then
TextReply = 'هـوۿ انته بلعـࢪاق لعد بتࢪڪيا طبعاً حاࢪه..🌶️'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'هههه' then
TextReply = 'عليـمن تضحڪ عله صخام ابوڪ عله صخام امڪ..🥤'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'ههههه' then
TextReply = 'يضـحڪ الفطيࢪ..🎀'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == '😹' then
TextReply = 'دايمه ان شاء الله '
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'وين' then
TextReply = 'علـه بحࢪ اشمـس ويـن يعني يـمڪ..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'كافي لغوه' then
TextReply = 'دنـجب قنفـذ..🦇'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'نايمين' then
TextReply = 'لا يـࢪوحي ڪلـمن لازم صاحبـته وڪام للصبح..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'اكو احد' then
TextReply = 'صـاࢪو ثنـين شون..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'فديت' then
TextReply = 'لصيـࢪ لوڪي ڪلبي..🍼'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'شكو' then
TextReply = 'ماڪو شي بس ملل..🍒'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'اوف' then
TextReply = 'اوف يروحي شبيك ضايج'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'احبج' then
TextReply = 'دنجـب لڪ ڪساع تحـب وحده ڪلب لو ڪوستࢪ..🔫'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
if text == 'انتة منو' then
TextReply = 'إﻧــي وائل @WYYYYY'
send(msg.chat_id_, msg.id_,'['..TextReply..']')
return false
end
end

if text == 'تفعيل ردود البوت' and Manager(msg) then
database:del(bot_id..'Reply:Status'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'⌯ ⁞ تم تفعيل ردود البوت')
return false
end

if text == 'تعطيل ردود البوت' and Manager(msg) then
database:set(bot_id..'Reply:Status'..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,'⌯ ⁞ تم تعطيل ردود البوت')
return false
end

end
return {
RiNdA = Reply
}
