﻿#Область ПрограммныйИнтерфейс
// Раздел содержит экспортные процедуры и функции, предназначенные для использования другими объектами 
// конфигурации или другими программами (например, через внешнее соединение).

//TODO: Добавить описание процедуры
Процедура МодифицироватьФорму(Форма, МакетОписаниеМодификаций, ГенераторПротокола = Неопределено) Экспорт
	Если ГенераторПротокола = Неопределено Тогда
		ГенераторПротокола = Обработки.ГенераторПротоколаМодификацииФормПоУмолчанию.СоздатьГенераторПротокола();
	КонецЕсли;
	
	ОписаниеМодификаций = ОписаниеМодификаций(МакетОписаниеМодификаций, ГенераторПротокола);
	МодифицироватьРеквизиты(Форма, ОписаниеМодификаций, ГенераторПротокола);
КонецПроцедуры // МодифицироватьФорму()

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
// Раздел предназначен для модулей, которые являются частью некоторой функциональной подсистемы. В нем 
// должны быть размещены экспортные процедуры и функции, которые допустимо вызывать только из других 
// функциональных подсистем этой же библиотеки.
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// Раздел содержит процедуры и функции, составляющие внутреннюю реализацию общего модуля. В тех случаях, 
// когда общий модуль является частью некоторой функциональной подсистемы, включающей в себя несколько 
// объектов метаданных, в этом разделе также могут быть размещены служебные экспортные процедуры и функции, 
// предназначенные только для вызова из других объектов данной подсистемы.

#Область ОписаниеМодификаций
	
#Область ИдентификаторыСтрок

Функция СтрокаРеквизита()
	Возврат "РЕКВИЗИТ";
КонецФункции // СтрокаРеквизита()

Функция СтрокаТипаРеквизита()
	Возврат "ТИПРЕКВИЗИТА";
КонецФункции // СтрокаТипаРеквизита()
	
#КонецОбласти

Функция ОписаниеМодификаций(МакетОписаниеМодификаций, ГенераторПротокола)
	РазделительПолей = Символы.Таб;
	РезультатФункции = СоздатьСтруктуруОписанияМодификаций();
	
	Для Сч = 1 По МакетОписаниеМодификаций.КоличествоСтрок() Цикл
		СтрокаДокумента = МакетОписаниеМодификаций.ПолучитьСтроку(Сч);
		ПоляИзСтроки = ПоляИзСтроки(СтрокаДокумента, РазделительПолей);
		Попытка
			ОбработатьПоля(РезультатФункции, ПоляИзСтроки, ГенераторПротокола);
		Исключение
			ОписаниеОшибки = СоздатьСтруктуруОписанияОшибки();
			ЗаполнитьОписаниеОшибкиИзИнформацииОбОшибке(ОписаниеОшибки, ИнформацияОбОшибке());
			ОписаниеОшибки.НомерСтрокиМакета = Сч;
			ОписаниеОшибки.СтрокаМакета = СтрокаДокумента;
			ГенераторПротокола.ОбработатьОшибку(ОписаниеОшибки);
			Если ГенераторПротокола.ПрерватьМодификациюПриОшибке() Тогда
				ВызватьИсключение;
			КонецЕсли;	
		КонецПопытки;
	КонецЦикла;
	
	Возврат РезультатФункции;
КонецФункции // ОписаниеМодификаций()

Функция СоздатьСтруктуруОписанияМодификаций()
	РезультатФункции = Новый Структура;
	
	РезультатФункции.Вставить("Реквизиты", Новый Структура);
	
	Возврат РезультатФункции;
КонецФункции // СоздатьСтруктуруОписанияМодификаций()

Функция ПоляИзСтроки(СтрокаСПолями, РазделительПолей)
	РезультатФункции = СтрРазделить(СтрокаСПолями, РазделительПолей, Ложь);
	
	Возврат РезультатФункции;
КонецФункции // ПоляИзСтроки()

Функция СоздатьСтруктуруОписанияОшибки()
	РезультатФункции = Новый Структура;
	
	РезультатФункции.Вставить("ДополнительнаяИнформация", Неопределено);
	РезультатФункции.Вставить("ИмяМодуля", Неопределено);
	РезультатФункции.Вставить("ИсходнаяСтрока", Неопределено);
	РезультатФункции.Вставить("Код", Неопределено);
	РезультатФункции.Вставить("НомерСтроки", Неопределено);
	РезультатФункции.Вставить("Описание", Неопределено);
	РезультатФункции.Вставить("НомерСтрокиМакета", Неопределено);
	РезультатФункции.Вставить("СтрокаМакета", Неопределено);
	
	Возврат РезультатФункции;
КонецФункции // СоздатьСтруктуруИнформацииОбОшибке()

Процедура ЗаполнитьОписаниеОшибкиИзИнформацииОбОшибке(ОписаниеОшибки, ИнформацияОбОшибке)
	ЗаполнитьЗначенияСвойств(ОписаниеОшибки, ИнформацияОбОшибке);
	//ОписаниеОшибки.Вставить("ДополнительнаяИнформация", ИнформацияОбОшибке.ДополнительнаяИнформация);
	//ОписаниеОшибки.Вставить("ИмяМодуля", ИнформацияОбОшибке.ИмяМодуля);
	//ОписаниеОшибки.Вставить("ИсходнаяСтрока", ИнформацияОбОшибке.ИсходнаяСтрока);
	//ОписаниеОшибки.Вставить("Код", ИнформацияОбОшибке.Код);
	//ОписаниеОшибки.Вставить("НомерСтроки", ИнформацияОбОшибке.НомерСтроки);
	//ОписаниеОшибки.Вставить("Описание", ИнформацияОбОшибке.Описание);
КонецПроцедуры // ЗаполнитьОписаниеОшибкиИзИнформацииОбОшибке()

Процедура ОбработатьПоля(ОписаниеМодификаций, Поля, ГенераторПротокола)
	Если Поля.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Идентификатор = ВРег(Поля[0]);
	Если Идентификатор = СтрокаРеквизита() Тогда
		ОбработатьСтрокуРеквизита(ОписаниеМодификаций, Поля, ГенераторПротокола);
	ИначеЕсли Идентификатор = СтрокаТипаРеквизита() Тогда
		ОбработатьСтрокуТипаРеквизита(ОписаниеМодификаций, Поля, ГенераторПротокола);
	Иначе
		Возврат;
	КонецЕсли;
КонецПроцедуры // ОбработатьПоля()

#Область ОбработкаПолей
	
Процедура ОбработатьСтрокуРеквизита(ОписаниеМодификаций, Поля, ГенераторПротокола)
	ИмяРеквизита = Поля[1];
	Если ОписаниеМодификаций.Реквизиты.Свойство(ИмяРеквизита) Тогда
		ОписаниеРеквизита = ОписаниеМодификаций.Реквизиты[ИмяРеквизита];
	Иначе
		ОписаниеРеквизита = Новый Структура;
	КонецЕсли;
	ОписаниеРеквизита.Вставить("ИмяРеквизита", ИмяРеквизита);
	ОписаниеРеквизита.Вставить("ТипРеквизита", Новый Соответствие);
	
	ОписаниеМодификаций.Реквизиты.Вставить(ИмяРеквизита, ОписаниеРеквизита);
КонецПроцедуры // ОбработатьСтрокуРеквизита()

Процедура ОбработатьСтрокуТипаРеквизита(ОписаниеМодификаций, Поля, ГенераторПротокола)
	КоличествоПолей = Поля.Количество();
	Если КоличествоПолей < 3 Тогда
		ВызватьИсключение СтрШаблон(НСтр("ru='Неправильный формат описания типа реквизита: ожидается полей 3, указано полей %1'"), КоличествоПолей);
	КонецЕсли;
	ИмяРеквизита = Поля[1];
	Если Не ОписаниеМодификаций.Реквизиты.Свойство(ИмяРеквизита) Тогда
		ВызватьИсключение СтрШаблон(НСтр("ru='Отсутствует описание реквизита ""%1""'"), ИмяРеквизита);
	КонецЕсли;
	ОписаниеРеквизита = ОписаниеМодификаций.Реквизиты[ИмяРеквизита].ТипРеквизита.Вставить(Поля[3], Неопределено);
КонецПроцедуры // ОбработатьСтрокуТипаРеквизита()

#КонецОбласти

#КонецОбласти

#Область МодификацияРеквизитов

Процедура МодифицироватьРеквизиты(Форма, ОписаниеМодификаций, ОбработчикОшибок)
	ДобавляемыеРеквизиты = Новый Массив;
	Для Каждого Элемент Из ОписаниеМодификаций.Реквизиты Цикл
		
	КонецЦикла;
КонецПроцедуры // МодифицироватьРеквизиты()

#КонецОбласти

#КонецОбласти

