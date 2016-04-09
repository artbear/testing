﻿

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьДеревоМетаданных();
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы



#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы_ДеревоМетаданных

&НаКлиенте
Процедура ДеревоМетаданныхПометкаПриИзменении(Элемент)
	ИДТекущейСтроки = Элементы.ДеревоМетаданных.ТекущаяСтрока;
	ЭлементКоллекции = Объект.ДеревоМетаданных.НайтиПоИдентификатору(ИДТекущейСтроки);
	Для Каждого ПодчиненнаяСтрока Из ЭлементКоллекции.ПолучитьЭлементы() Цикл
		ПодчиненнаяСтрока.Пометка = ЭлементКоллекции.Пометка;
	КонецЦикла;
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выгрузить(Команда)
	ТабличныйДокумент = ВыгрузитьНаСервере();
	ТабличныйДокумент.Показать()
КонецПроцедуры

&НаКлиенте
Процедура СвернутьДеревоМетаданных(Команда)
	Для Каждого Строка Из Объект.ДеревоМетаданных.ПолучитьЭлементы() Цикл
		ИдентификаторСтроки = Строка.ПолучитьИдентификатор();
		Элементы.ДеревоМетаданных.Свернуть(ИдентификаторСтроки);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура РазвернутьДеревоМетаданных(Команда)
	Для Каждого Строка Из Объект.ДеревоМетаданных.ПолучитьЭлементы() Цикл
		ИдентификаторСтроки = Строка.ПолучитьИдентификатор();
		Элементы.ДеревоМетаданных.Развернуть(ИдентификаторСтроки);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьВсе(Команда)
	УстановитьСнятьФлажки(Истина);
КонецПроцедуры

&НаКлиенте
Процедура СнятьОтметки(Команда)
	УстановитьСнятьФлажки(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ИсключитьОбъектыПоСписку(Команда)
	Оповещение = Новый ОписаниеОповещения("ИсключитьОбъектыПоСпискуЗавершение", ЭтаФорма);
	
	ПоказатьВводСтроки(Оповещение, "", "Введите список объектов-исключений", , Истина);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьРассчетКоличестваЭлементов(Команда)
	РассчитатьКоличествоЭлементовНаСервре();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьДеревоМетаданных()
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	Дерево = ОбработкаОбъект.ДеревоМетаданных;
	
	СтрокаРодитель = Дерево.Строки.Добавить();
	СтрокаРодитель.Имя = "Константы";
	СтрокаРодитель.ИндексКартинки = 4;
	СтрокаРодитель.Пометка = Истина;
	
	СтрокаРодитель = Дерево.Строки.Добавить();
	СтрокаРодитель.Имя = "Справочники";
	СтрокаРодитель.ИндексКартинки = 0;
	СтрокаРодитель.Пометка = Истина;
	
	СтрокаРодитель = Дерево.Строки.Добавить();
	СтрокаРодитель.Имя = "Документы";
	СтрокаРодитель.ИндексКартинки = 14;
	СтрокаРодитель.Пометка = Истина;
	
	СтрокаРодитель = Дерево.Строки.Добавить();
	СтрокаРодитель.Имя = "РегистрыСведений";
	СтрокаРодитель.ИндексКартинки = 8;
	СтрокаРодитель.Пометка = Истина;
	
	СтрокаРодитель = Дерево.Строки.Добавить();
	СтрокаРодитель.Имя = "РегистрыНакопления";
	СтрокаРодитель.ИндексКартинки = 5;
	СтрокаРодитель.Пометка = Истина;
	
	Для Каждого СтрокаРодитель Из Дерево.Строки Цикл
		Для Каждого ВидОбъекта Из Метаданные[СтрокаРодитель.Имя] Цикл
			Строка = СтрокаРодитель.Строки.Добавить();
			Строка.Имя = ВидОбъекта.Имя;
			Строка.Синоним = ВидОбъекта.Синоним;
			Строка.ИндексКартинки = СтрокаРодитель.ИндексКартинки;
			Строка.Пометка = СтрокаРодитель.Пометка;
		КонецЦикла;
		
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ОбработкаОбъект, "Объект");
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСнятьФлажки(Пометка)
	Для Каждого СтрокаРодитель Из Объект.ДеревоМетаданных.ПолучитьЭлементы() Цикл
		СтрокаРодитель.Пометка = Пометка;
		Для Каждого Строка Из СтрокаРодитель.ПолучитьЭлементы() Цикл
			Строка.Пометка = Пометка;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция ВыгрузитьНаСервере()
	СводныйТабличныйДокумент = Новый ТабличныйДокумент;
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	Для Каждого СтрокаРодитель Из Объект.ДеревоМетаданных.ПолучитьЭлементы() Цикл
		
		Область = СводныйТабличныйДокумент.Область(СводныйТабличныйДокумент.ВысотаТаблицы+2, 2);
		Область.Текст = "// " + ВРег(СтрокаРодитель.Имя);
		Область.ЦветТекста = WebЦвета.ЗеленыйЛес;
		Область.Шрифт = Новый Шрифт(,11,Истина);
		СводныйТабличныйДокумент.НачатьГруппуСтрок(СтрокаРодитель.Имя, Ложь);
		
		
		Для Каждого Строка Из СтрокаРодитель.ПолучитьЭлементы() Цикл
			Если Строка.Пометка = Ложь Тогда
				Продолжить;
			КонецЕсли;
			
			Тип = СтрокаРодитель.Имя;
			Вид = Строка.Имя;
			ТипДанных = Вычислить("Метаданные." + Тип + "." + Вид).ПолноеИмя();
			
			Попытка
				ТаблицаСДанными = ПолучитьТаблицуЗначенийПоТипуМетаданных(ТипДанных);
				
				Если ТаблицаСДанными.Количество() = 0 Тогда
					Продолжить;
				ИначеЕсли Тип = "Константы" Тогда
					Если НЕ ЗначениеЗаполнено(ТаблицаСДанными[0][0]) Тогда
						Продолжить;
					ИначеЕсли ТипЗнч(ТаблицаСДанными[0][0]) = Тип("ХранилищеЗначения") Тогда
						Продолжить;
					КонецЕсли;
				КонецЕсли;
				
				ТабличныйДокумент = ОбработкаОбъект.ВыгрузитьТаблицуЗначенийВТабличныйДокумент(ТаблицаСДанными, ТипДанных);
				СводныйТабличныйДокумент.Вывести(ТабличныйДокумент);
			Исключение
				Сообщить("Не удалось выгрузить " + ТипДанных + " по причине: " + ОписаниеОшибки());
			КонецПопытки;
		КонецЦикла;
		
		СводныйТабличныйДокумент.ЗакончитьГруппуСтрок();
	КонецЦикла;
	
	Возврат СводныйТабличныйДокумент;
КонецФункции

Функция ПолучитьТаблицуЗначенийПоТипуМетаданных(ТипДанных)
	
	Если Найти(ТипДанных, "Константа") = 1 Тогда
		ТекстЗапроса = 
		"выбрать "+СтрЗаменить(ТипДанных, "Константа.", "")+"
		|из Константы";
	Иначе
		ТекстЗапроса = 
		"выбрать *
		|из "+ТипДанных;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	ТаблицаСДанными = Запрос.Выполнить().Выгрузить();
	
	НайденнаяКолонка = ТаблицаСДанными.Колонки.Найти("ВерсияДанных");
	Если НЕ НайденнаяКолонка = Неопределено Тогда
		ТаблицаСДанными.Колонки.Удалить(НайденнаяКолонка);
	КонецЕсли;
	
	
	Возврат ТаблицаСДанными;
КонецФункции

&НаКлиенте
Процедура ИсключитьОбъектыПоСпискуЗавершение(Результат, Параметры) Экспорт
	ИсключитьОбъектыПоСпискуНаСервере(Результат);
КонецПроцедуры

&НаСервере
Процедура ИсключитьОбъектыПоСпискуНаСервере(СписокСинонимовИлиИдентификаторовСтрокой)
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	Для сч = 1 По СтрЧислоСтрок(СписокСинонимовИлиИдентификаторовСтрокой) Цикл
		Строка = СтрПолучитьСтроку(СписокСинонимовИлиИдентификаторовСтрокой, сч);
		Если ПустаяСтрока(Строка) Тогда
			Продолжить;
		КонецЕсли;
		
		Для СчетчикПолей = 1 по 2 Цикл
			Отбор = Новый Структура;
			Отбор.Вставить(?(СчетчикПолей=1, "Имя", "Синоним"), Строка);
			НайденыеСтроки = ОбработкаОбъект.ДеревоМетаданных.Строки.НайтиСтроки(Отбор, Истина);
			Для Каждого НайденнаяСтрока Из НайденыеСтроки Цикл
				НайденнаяСтрока.Пометка = Ложь;
			КонецЦикла;
		КонецЦикла;
		
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ОбработкаОбъект, "Объект");
	
КонецПроцедуры

&НаСервере
Процедура РассчитатьКоличествоЭлементовНаСервре()
	Для Каждого СтрокаТип Из Объект.ДеревоМетаданных.ПолучитьЭлементы() Цикл
		
		Тип = СтрокаТип.Имя;
		Если Тип = "Справочники" Тогда
			ТипВЗапросе = "Справочник";
		ИначеЕсли Тип = "Документы" Тогда
			ТипВЗапросе = "Документ";
		ИначеЕсли Тип = "РегистрыСведений" Тогда
			ТипВЗапросе = "РегистрСведений";
		ИначеЕсли Тип = "РегистрыНакопления" Тогда
			ТипВЗапросе = "РегистрНакопления";
		Иначе
			Продолжить;
		КонецЕсли;
		
		Для Каждого СтрокаВид Из СтрокаТип.ПолучитьЭлементы() Цикл
			ТекстЗапроса = 
			"ВЫБРАТЬ
			|	СУММА(1) КАК Количество
			|ИЗ
			|	Тип_Вид КАК т";
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Тип_Вид", ТипВЗапросе + "." + СтрокаВид.Имя);
			Запрос = Новый Запрос(ТекстЗапроса);
			Выборка = Запрос.Выполнить().Выбрать();
			Выборка.Следующий();
			СтрокаВид.КоличествоЭлементов = Выборка.Количество;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры


#КонецОбласти




