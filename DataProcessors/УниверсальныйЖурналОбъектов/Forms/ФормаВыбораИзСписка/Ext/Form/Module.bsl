﻿

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Заголовок = Параметры.Заголовок;
	Список = Параметры.Список;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОписаниеОповещенияОЗакрытии.ДополнительныеПараметры.Вставить("Список", Список);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы



#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы_ИмяТаблицы



#КонецОбласти

#Область ОбработчикиКомандФормы



#КонецОбласти

#Область СлужебныеПроцедурыИФункции



#КонецОбласти
