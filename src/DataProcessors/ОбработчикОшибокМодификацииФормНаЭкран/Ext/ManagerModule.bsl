﻿#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс

// TODO: Добавить описание функции
Функция СоздатьОбработчикОшибок(ПрерватьМодификациюПриОшибке) Экспорт 
	ОбработчикОшибок = Обработки.ОбработчикОшибокМодификацииФормНаЭкран.Создать();
	ОбработчикОшибок.ПрерватьМодификациюПриОшибке = ПрерватьМодификациюПриОшибке;
	
	Возврат ОбработчикОшибок;
КонецФункции // СоздатьОбработчикОшибок()

// Раздел содержит экспортные процедуры и функции, предназначенные для использования в других модулях 
// конфигурации или другими программами (например, через внешнее соединение). Не следует в этот раздел
// помещать экспортные функции и процедуры, которые предназначены для вызова исключительно из модулей
// самого объекта, его форм и команд. Например, процедуры заполнения табличной части документа, 
// которые вызываются из обработки заполнения в модуле объекта и из формы документа в обработчике 
// команды формы не являются программным интерфейсом модуля объекта, т.к. вызываются только в самом 
// модуле и из форм этого же объекта. Их следует размещать в разделе "Служебные процедуры и функции".
#КонецОбласти

#Область ОбработчикиСобытий
// Раздел содержит обработчики событий модуля объекта (ПриЗаписи, ПриПроведении и др.)
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
#КонецОбласти

#Область Инициализация

#КонецОбласти
