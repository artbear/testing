﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	ВыполнитьДвиженияПоРегистру_РегистрНакопления1();
	
КонецПроцедуры


Процедура ВыполнитьДвиженияПоРегистру_РегистрНакопления1()
	Движения.РегистрНакопления1.Записывать = Истина;
	Движения.РегистрНакопления1.Очистить();
	Для Каждого ТекСтрокаТабличнаяЧасть1 Из ТабличнаяЧасть1 Цикл
		Движение = Движения.РегистрНакопления1.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Измерение1 = Реквизит1;
		Движение.Реквизит1 = ТекСтрокаТабличнаяЧасть1.Реквизит1;
		Движение.Реквизит2 = Реквизит2;
		Движение.Реквизит21 = ТекСтрокаТабличнаяЧасть1.РеквизитТЧ2;
		Движение.Ресурс1 = ТекСтрокаТабличнаяЧасть1.Ресурс1;
	КонецЦикла;
	
	Движения.РегистрНакопления1.Записать(Истина);
КонецПроцедуры


#Область _// Автотесты

Процедура ВыполнитьВКонтексте(Команда, Параметр = Неопределено) Экспорт
	
	Выполнить(Команда);
	
КонецПроцедуры
	
#КонецОбласти
