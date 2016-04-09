﻿
Процедура ЗаполнитьДеревоЗначений() Экспорт
	ДеревоКонфигурации.Строки.Очистить();
	
	Корень = ДеревоКонфигурации.Строки.Добавить();
	Корень.Имя = Метаданные.Имя;
	Корень.Синоним = Метаданные.Синоним;
	Корень.ИндексКартинки = 0;
	
	Узел = Корень.Строки.Добавить();
	Узел.Имя = "Справочники";
	Узел.Тип = "Справочник";
	Узел.ИндексКартинки = 4;
	ДобавитьОбъектыПоТипу(Узел);
	
	Узел = Корень.Строки.Добавить();
	Узел.Имя = "Документы";
	Узел.Тип = "Документ";
	Узел.ИндексКартинки = 7;
	ДобавитьОбъектыПоТипу(Узел);
	
	Узел = Корень.Строки.Добавить();
	Узел.Имя = "РегистрыНакопления";
	Узел.Тип = "РегистрНакопления";
	Узел.ИндексКартинки = 17;
	ДобавитьОбъектыПоТипу(Узел);
	
КонецПроцедуры

Процедура ДобавитьОбъектыПоТипу(УзелТипа)
	
	Для Каждого МетаОбъект Из Метаданные[УзелТипа.Имя] Цикл
		НовыйУзел = УзелТипа.Строки.Добавить();
		ЗаполнитьЗначенияСвойств(НовыйУзел, УзелТипа);
		
		НовыйУзел.Имя = МетаОбъект.Имя;
		НовыйУзел.Синоним = МетаОбъект.Синоним;
		
	КонецЦикла;
	
КонецПроцедуры
