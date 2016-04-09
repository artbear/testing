﻿// Добавляет колонки в элемент формы типа ТаблицаФормы. Это видимая таблица.
// НаборРеквизитов - метаданные набора реквизитов или коллекция колонок таблицы значений
//					Колонки табличной части создаются по стандартным реквизитам, реквизитам, измерениям, ресурсам.
// ЭлементФормы - ТаблицаФормы в которой нужно создать колонки
// ИмяРеквизитаФормы - источник данных для ЭлементФормы. В нём уже есть клонки, соответсвующие создаваемым.
&НаСервере
Процедура ДобавитьКолонкиВЭлементФормы(НаборРеквизитов, ЭлементФормы, ИмяРеквизитаФормы)
	Если ТипЗнч(НаборРеквизитов) = Тип("КоллекцияКолонокТаблицыЗначений") Тогда
		Для каждого КолонкаРекв Из НаборРеквизитов Цикл
			Если КолонкаРекв.Имя = "МоментВремени" Тогда
				Продолжить
			КонецЕсли; 
			Колонка = ЭтаФорма.Элементы.Добавить(ЭлементФормы.Имя + КолонкаРекв.Имя, Тип("ПолеФормы"), ЭлементФормы);
			Колонка.Вид = ?(КолонкаРекв.ТипЗначения.Типы().Количество() = 1 И КолонкаРекв.ТипЗначения.Типы()[0] = Тип("Булево"), ВидПоляФормы.ПолеФлажка, ВидПоляФормы.ПолеВвода);
			Колонка.ПутьКДанным = ИмяРеквизитаФормы + "." + КолонкаРекв.Имя;
			Колонка.Подсказка = КолонкаРекв.Заголовок;
			Колонка.ТолькоПросмотр = КолонкаРекв.Имя = "НомерСтроки" или КолонкаРекв.Имя = "LineNumber";
		КонецЦикла; 
	Иначе // Если ТипЗнч(НаборРеквизитов) = Тип("КоллекцияКолонокТаблицыЗначений") Тогда // метаданные
		Для каждого мдРеквизита Из НаборРеквизитов Цикл
			Колонка = ЭтаФорма.Элементы.Добавить(ЭлементФормы.Имя + мдРеквизита.Имя, Тип("ПолеФормы"), ЭлементФормы);
			Колонка.Вид = ?(мдРеквизита.Тип.Типы().Количество() = 1 И мдРеквизита.Тип.Типы()[0] = Тип("Булево"), ВидПоляФормы.ПолеФлажка, ВидПоляФормы.ПолеВвода);
			Колонка.ПутьКДанным = ИмяРеквизитаФормы + "." + мдРеквизита.Имя;
			Колонка.Подсказка = мдРеквизита.Синоним;
			Колонка.ТолькоПросмотр = мдРеквизита.Имя = "НомерСтроки" или мдРеквизита.Имя = "LineNumber";
		КонецЦикла; 
	КонецЕсли; 
КонецПроцедуры

// Добавляет в массив описания колонок реквизита формы типа ТаблицаЗначений. Это таблица, хранящая данные.
// ДобавляемыеРеквизиты - массив в окотором собираются описания добавляемых реквизитов
// НаборРеквизитов - метаданные набора реквизитов или коллекция колонок таблицы значений
//					Колонки табличной части создаются по стандартным реквизитам, реквизитам, измерениям, ресурсам.
// ИмяРеквизитаФормы - источник данных для ЭлементФормы. В нём уже есть клонки, соответсвующие создаваемым.
&НаСервере
Процедура ДобавитьКолонкиВРеквизитФормы(ДобавляемыеРеквизиты, НаборРеквизитов, ИмяРеквизитаФормы)
	Если ТипЗнч(НаборРеквизитов) = Тип("КоллекцияКолонокТаблицыЗначений") Тогда
		Для каждого Колонка Из НаборРеквизитов Цикл
			Если Колонка.Имя = "МоментВремени" Тогда
				Продолжить
			КонецЕсли; 
			ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы(Колонка.Имя,
											?(Колонка.ТипЗначения.СодержитТип(Тип("ХранилищеЗначения")), Новый ОписаниеТипов("Строка"), Колонка.ТипЗначения),
											ИмяРеквизитаФормы,
											Колонка.Имя + ?(Колонка.Заголовок = Колонка.Имя, "", " (" + Колонка.Заголовок + ")"),
											Истина));
		КонецЦикла; 
	Иначе // Если ТипЗнч(НаборРеквизитов) = Тип("КоллекцияКолонокТаблицыЗначений") Тогда // метаданные
		Для каждого мдРеквизита Из НаборРеквизитов Цикл
			ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы(мдРеквизита.Имя,
											?(мдРеквизита.Тип.СодержитТип(Тип("ХранилищеЗначения")), Новый ОписаниеТипов("Строка"), мдРеквизита.Тип),
											ИмяРеквизитаФормы,
											мдРеквизита.Имя + ?(ПустаяСтрока(мдРеквизита.Синоним), "", " (" + мдРеквизита.Синоним + ")"),
											Истина));
		КонецЦикла; 
	КонецЕсли; 
КонецПроцедуры

&НаСервере
Процедура ДабавитьТаблицыДвиженийНаФорму()
	мдОбъекта = ВыбСсылка.Метаданные();
	ВыбОбъект = ВыбСсылка.ПолучитьОбъект();
	ДобавляемыеРеквизиты = Новый Массив;
	
	// Ключ - имя реквизита формы
	// Значение - тз с движениями
	ДвиженияДокумента = Новый Соответствие;
	Для каждого мдРегистра Из мдОбъекта.Движения Цикл
		НаборЗаписей = ВыбОбъект.Движения[мдРегистра.Имя];
		НаборЗаписей.Прочитать();
		Если ПоказыватьТолькоРегистрыСДвижениями И НаборЗаписей.Количество() = 0 Тогда
			Продолжить
		КонецЕсли; 
		
		Если Метаданные.РегистрыБухгалтерии.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРБ" + мдРегистра.Имя;
		ИначеЕсли Метаданные.РегистрыНакопления.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРН" + мдРегистра.Имя;
		ИначеЕсли Метаданные.РегистрыРасчета.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРР" + мдРегистра.Имя;
		ИначеЕсли Метаданные.РегистрыСведений.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРС" + мдРегистра.Имя;
		КонецЕсли; 
		
		// таблица движений по регистру
		ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы(ИмяРеквизитаФормы,
										Новый ОписаниеТипов("ТаблицаЗначений"),
										,
										мдРегистра.Имя + ?(мдРегистра.Имя = мдРегистра.Представление(), "", " (" + мдРегистра.Представление() + ")"),
										Истина));
		
		тзДвижений = НаборЗаписей.Выгрузить();
		ДвиженияДокумента.Вставить(ИмяРеквизитаФормы, тзДвижений);
		// Колонки таблицы
		ДобавитьКолонкиВРеквизитФормы(ДобавляемыеРеквизиты, тзДвижений.Колонки, ИмяРеквизитаФормы);
		
	КонецЦикла; 
	ЭтаФорма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	Для каждого мдРегистра Из мдОбъекта.Движения Цикл
		Если Метаданные.РегистрыБухгалтерии.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРБ" + мдРегистра.Имя;
			ИмяРодительскойЗакладки = "ЗакладкиРБ";
		ИначеЕсли Метаданные.РегистрыНакопления.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРН" + мдРегистра.Имя;
			ИмяРодительскойЗакладки = "ЗакладкиРН";
		ИначеЕсли Метаданные.РегистрыРасчета.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРР" + мдРегистра.Имя;
			ИмяРодительскойЗакладки = "ЗакладкиРР";
		ИначеЕсли Метаданные.РегистрыСведений.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРС" + мдРегистра.Имя;
			ИмяРодительскойЗакладки = "ЗакладкиРС";
		КонецЕсли; 
		тзДвижений = ДвиженияДокумента.Получить(ИмяРеквизитаФормы);
		Если тзДвижений = Неопределено Тогда
			Продолжить
		КонецЕсли; 
		
		// Добавляем закладку для каждого регистра
		ЭлементЗакладка = ЭтаФорма.Элементы.Добавить("lyay" + ИмяРодительскойЗакладки + мдРегистра.Имя, Тип("ГруппаФормы"), ЭтаФорма.Элементы[ИмяРодительскойЗакладки]);
		ЭлементЗакладка.Вид = ВидГруппыФормы.Страница;
		ЭлементЗакладка.Заголовок = мдРегистра.Имя;
		ЭлементЗакладка.Подсказка = мдРегистра.Представление();
		
		// Создаём таблицу (элемент формы) для отображения движений
		ЭлементФормы = ЭтаФорма.Элементы.Добавить(ИмяРеквизитаФормы, Тип("ТаблицаФормы"), ЭтаФорма.Элементы["lyay" + ИмяРодительскойЗакладки + мдРегистра.Имя]);
		ЭлементФормы.ПутьКДанным = ИмяРеквизитаФормы;
		ЭлементФормы.Подсказка = мдРегистра.Комментарий;
		ЭлементФормы.Заголовок = мдРегистра.Синоним;
		
		// Колонки таблицы
		//тзДвижений = ДвиженияДокумента[ИмяРеквизитаФормы];
		ДобавитьКолонкиВЭлементФормы(тзДвижений.Колонки, ЭлементФормы, ИмяРеквизитаФормы);
		
		// заодно заполним данные в реквизиты формы
		Для каждого СтрокаДвижений Из тзДвижений Цикл
			тзРеквизитФормы = ЭтаФорма[ИмяРеквизитаФормы];
			СтрокаТЗРеквизита = тзРеквизитФормы.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТЗРеквизита, СтрокаДвижений);
		КонецЦикла;
	КонецЦикла; 
КонецПроцедуры

&НаСервере
Процедура ДобавитьРеквизитыНаФорму(НаборРеквизитов, ИмяГруппыКудаДобавлять)
	// Добавляем реквизиты формы
	ДобавляемыеРеквизиты = Новый Массив;
	Для каждого мдРеквизита Из НаборРеквизитов Цикл
		ИмяРеквизитаФормы = "lyay" + мдРеквизита.Имя;
		Если мдРеквизита.Имя = "Ссылка" или мдРеквизита.Имя = "Ref" ИЛИ мдРеквизита.Тип.СодержитТип(Тип("ХранилищеЗначения")) Тогда
			ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы(ИмяРеквизитаФормы,
											Новый ОписаниеТипов("Строка"),
											,
											мдРеквизита.Имя,
											Истина));
		Иначе
			ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы(ИмяРеквизитаФормы,
											мдРеквизита.Тип,
											,
											мдРеквизита.Имя + ?(ПустаяСтрока(мдРеквизита.Синоним), "", " (" + мдРеквизита.Синоним + ")"),
											Истина));
		КонецЕсли;
	КонецЦикла; 
	ЭтаФорма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	// Добавляем элементы формы к добавленным реквизитам
	Для каждого мдРеквизита Из НаборРеквизитов Цикл
		
		ИмяРеквизитаФормы = "lyay" + мдРеквизита.Имя;
		Элемент = ЭтаФорма.Элементы.Добавить(ИмяРеквизитаФормы, Тип("ПолеФормы"), ЭтаФорма.Элементы[ИмяГруппыКудаДобавлять]);
		// Заполним добавленные реквизиты
		Если мдРеквизита.Имя = "Ссылка" или мдРеквизита.Имя = "Ref" Тогда
			Элемент.ТолькоПросмотр = Истина;
			ЭтаФорма[ИмяРеквизитаФормы] = Строка(ВыбСсылка.УникальныйИдентификатор());
		Иначе
			Если мдРеквизита.Тип.СодержитТип(Тип("ХранилищеЗначения")) Тогда
				Элемент.ТолькоПросмотр = Истина;
				ЭтаФорма[ИмяРеквизитаФормы] = "Хранилище значения";
			Иначе
				Элемент.ТолькоПросмотр = мдРеквизита.Имя = "Предопределенный" или мдРеквизита.Имя = "Predefined" ИЛИ
											мдРеквизита.Имя = "Проведен" ИЛИ мдРеквизита.Имя = "Posted" ИЛИ
											мдРеквизита.Имя = "ЭтоГруппа" ИЛИ мдРеквизита.Имя = "IsFolder";
				ЭтаФорма[ИмяРеквизитаФормы] = ВыбСсылка[мдРеквизита.Имя];
			КонецЕсли; 
		КонецЕсли;
		
		Если мдРеквизита.Тип.Типы().Количество() = 1 И мдРеквизита.Тип.Типы()[0] = Тип("Булево") Тогда
			Элемент.Вид = ВидПоляФормы.ПолеФлажка
		Иначе
			Элемент.Вид = ВидПоляФормы.ПолеВвода;
		КонецЕсли;
		
		Элемент.ПутьКДанным = ИмяРеквизитаФормы;
		Элемент.Подсказка = мдРеквизита.Синоним;
		
		Если мдРеквизита.Тип.СодержитТип(Тип("Строка")) и мдРеквизита.Тип.КвалификаторыСтроки.Длина = 0 Тогда
			Элемент.МногострочныйРежим = Истина;
			Элемент.Высота = 5;
		КонецЕсли
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ДобавитьТабличнуюЧастьНаФорму(мдТабличнойЧасти)
	ИмяРеквизитаФормыТЧ = "lyayТч" + мдТабличнойЧасти.Имя;
	// Добавляем реквизит формы таблицу значений
	ДобавляемыеРеквизиты = Новый Массив;
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы(ИмяРеквизитаФормыТЧ,
									Новый ОписаниеТипов("ТаблицаЗначений"),
									,
									мдТабличнойЧасти.Имя + ?(мдТабличнойЧасти.Имя = мдТабличнойЧасти.Представление(), "", " (" + мдТабличнойЧасти.Представление() + ")"),
									Истина));
									
	// добавим колонки в реквизит формы - табличную часть
	// сначала стандартные реквизиты табличной части
	ДобавитьКолонкиВРеквизитФормы(ДобавляемыеРеквизиты, мдТабличнойЧасти.СтандартныеРеквизиты, ИмяРеквизитаФормыТЧ);
	
	// затем остальные реквизиты табличной части
	Если НЕ ТипЗнч(мдТабличнойЧасти) = Тип("ОписаниеСтандартнойТабличнойЧасти") Тогда
		ДобавитьКолонкиВРеквизитФормы(ДобавляемыеРеквизиты, мдТабличнойЧасти.Реквизиты, ИмяРеквизитаФормыТЧ);
	КонецЕсли; 
	ЭтаФорма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	// Заполним добавленные реквизиты
	тз = ЭтаФорма[ИмяРеквизитаФормыТЧ];
	Для каждого стр Из ВыбСсылка[мдТабличнойЧасти.Имя] Цикл
		СтрокаТаблицыНаФорме = тз.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТаблицыНаФорме, стр);
	КонецЦикла; 
	
	// Теперь работаем с элементами формы - тем что отображает данные
	// Добавляем закладку для каждой табличной части
	ЭлементЗакладкаТЧ = ЭтаФорма.Элементы.Добавить("lyayЗакладкаТч" + мдТабличнойЧасти.Имя, Тип("ГруппаФормы"), ЭтаФорма.Элементы.ЗакладкиТч);
	ЭлементЗакладкаТЧ.Вид = ВидГруппыФормы.Страница;
	ЭлементЗакладкаТЧ.Заголовок = мдТабличнойЧасти.Имя;
	ЭлементЗакладкаТЧ.Подсказка = мдТабличнойЧасти.Синоним;
	
	// Создаём таблицу (элемент формы) для отображения данных
	ЭлементФормыТЧ = ЭтаФорма.Элементы.Добавить(ИмяРеквизитаФормыТЧ, Тип("ТаблицаФормы"), ЭтаФорма.Элементы["lyayЗакладкаТч" + мдТабличнойЧасти.Имя]);
	ЭлементФормыТЧ.ПутьКДанным = ИмяРеквизитаФормыТЧ;
	ЭлементФормыТЧ.Подсказка = мдТабличнойЧасти.Комментарий;
	ЭлементФормыТЧ.Заголовок = мдТабличнойЧасти.Синоним;
	
	// Создаём колонки в отображаемой таблице
	// сначала стандартные реквизиты
	ДобавитьКолонкиВЭлементФормы(мдТабличнойЧасти.СтандартныеРеквизиты , ЭлементФормыТЧ, ИмяРеквизитаФормыТЧ);
	
	// затем остальные реквизиты табличной части. У стандартной табличной части нет Реквизитов, есть только  СтандартныеРеквизиты
	Если НЕ ТипЗнч(мдТабличнойЧасти) = Тип("ОписаниеСтандартнойТабличнойЧасти") Тогда
		ДобавитьКолонкиВЭлементФормы(мдТабличнойЧасти.Реквизиты , ЭлементФормыТЧ, ИмяРеквизитаФормыТЧ);
	Иначе
		// назначим обработчики событий для табличных частей
		ЭлементФормыТЧ.УстановитьДействие("ПередНачаломИзменения", "ПередНачаломИзмененияСтандартнойТЧ");
	КонецЕсли;
	ЭлементФормыТЧ.УстановитьДействие("ПередНачаломДобавления", "ПередНачаломДобавленияТЧ");
			
КонецПроцедуры

// удаляет реквизиты и элементы формы, оставшиеся от предыдущего объекта
&НаСервере
Процедура ОчиститьОтСтарыхРеквизитов()
	
	// удалим старые реквизиты формы
	ВсеРеквизиты = ЭтаФорма.ПолучитьРеквизиты();
	Удаляемые = Новый Массив;
	Для Каждого рекв  из ВсеРеквизиты Цикл
		Если Лев(рекв.Имя, 4) = "lyay" Тогда
			Удаляемые.Добавить(рекв.Имя);
		КонецЕсли;
	КонецЦикла;
	ЭтаФорма.ИзменитьРеквизиты(, Удаляемые);
	
	// Удалим элементы с формы. Для этого сначала соберём их в массив, а затем удалим. Иначе иногда валится 1С.
	Удаляемые = Новый Массив;
	Для Каждого ЭлементФормы из ЭтаФорма.Элементы Цикл
		Если Лев(ЭлементФормы.Имя, 4) = "lyay" и
				(ТипЗнч(ЭлементФормы) = Тип("ПолеФормы") И ТипЗнч(ЭлементФормы.Родитель) <> Тип("ТаблицаФормы") ИЛИ
					ТипЗнч(ЭлементФормы) = Тип("ГруппаФормы") и (ЭлементФормы.Родитель = ЭтаФорма.Элементы.ЗакладкиТч
																ИЛИ ЭлементФормы.Родитель = ЭтаФорма.Элементы.ЗакладкиРН
																ИЛИ ЭлементФормы.Родитель = ЭтаФорма.Элементы.ЗакладкиРС
																ИЛИ ЭлементФормы.Родитель = ЭтаФорма.Элементы.ЗакладкиРБ
																ИЛИ ЭлементФормы.Родитель = ЭтаФорма.Элементы.ЗакладкиРР)) Тогда
			Удаляемые.Добавить(ЭлементФормы);
		КонецЕсли;
	КонецЦикла;
	Для Каждого ЭлементФормы из Удаляемые Цикл
		ЭтаФорма.Элементы.Удалить(ЭлементФормы);
	КонецЦикла;
КонецПроцедуры

// Читает движения объекта и заполняет таблицы на форме
&НаСервере
Процедура ПрочитатьДвижения()
	Если ОбрабатыватьДвижения Тогда
		Если Метаданные.Документы.Индекс(ВыбСсылка.Метаданные()) >= 0 Тогда
			ДабавитьТаблицыДвиженийНаФорму();
		КонецЕсли;
	КонецЕсли; 
КонецПроцедуры // ПрочитатьДвижения()

&НаСервере
Процедура ПрочитатьОбъект() Экспорт
	ОчиститьОтСтарыхРеквизитов();
	Если Не ЗначениеЗаполнено(ВыбСсылка) Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "Объект не выбран";
		ЭтаФорма.Элементы.ЗаписатьИзменения.Доступность = Ложь;
		ЭтаФорма.Элементы.ФормаУдалитьОбъект.Доступность = Ложь;
		Возврат
	КонецЕсли;
	ЭтаФорма.Элементы.ЗаписатьИзменения.Доступность = Истина;
	ЭтаФорма.Элементы.ФормаУдалитьОбъект.Доступность = Истина;
	
	мдОбъекта = ВыбСсылка.Метаданные();
	Если Метаданные.Справочники.Индекс(мдОбъекта) >= 0 Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "Справочник." + мдОбъекта.Имя;
	ИначеЕсли Метаданные.Документы.Индекс(мдОбъекта) >= 0 Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "Документ." + мдОбъекта.Имя;
	ИначеЕсли Метаданные.ПланыВидовХарактеристик.Индекс(мдОбъекта) >= 0 Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "ПланВидовХарактеристик." + мдОбъекта.Имя;
	ИначеЕсли Метаданные.ПланыСчетов.Индекс(мдОбъекта) >= 0 Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "Счёт." + мдОбъекта.Имя;
	ИначеЕсли Метаданные.ПланыВидовРасчета.Индекс(мдОбъекта) >= 0 Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "Вид расчёта." + мдОбъекта.Имя;
	ИначеЕсли Метаданные.ПланыОбмена.Индекс(мдОбъекта) >= 0 Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "План обмена." + мдОбъекта.Имя;
	ИначеЕсли Метаданные.БизнесПроцессы.Индекс(мдОбъекта) >= 0 Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "Бизнес процесс." + мдОбъекта.Имя;
	ИначеЕсли Метаданные.Задачи.Индекс(мдОбъекта) >= 0 Тогда
		ЭтаФорма.Элементы.ВыбСсылка.Заголовок = "Задача." + мдОбъекта.Имя;
	Иначе
		Сообщить("Выбранный тип данных не поддерживается данной обработкой.");
		Возврат
	КонецЕсли;
	
	// Создадим массив общих реквизитов, относящихся к данному объекту
	МассивРеквизитов = Новый Массив;
	Для Каждого мдРеквизита из Метаданные.ОбщиеРеквизиты Цикл
		ЭлементСоставаОбщегоРеквизита = мдРеквизита.Состав.Найти(мдОбъекта);
		Если ЭлементСоставаОбщегоРеквизита.Использование = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.Использовать или
			ЭлементСоставаОбщегоРеквизита.Использование = Метаданные.СвойстваОбъектов.АвтоИспользованиеОбщегоРеквизита.Использовать
			и мдРеквизита.АвтоИспользование = Метаданные.СвойстваОбъектов.АвтоИспользованиеОбщегоРеквизита.Использовать Тогда
			МассивРеквизитов.Добавить(мдРеквизита);
		КонецЕсли;
	КонецЦикла;
	ДобавитьРеквизитыНаФорму(МассивРеквизитов, "ОбщиеРеквизиты");
	ДобавитьРеквизитыНаФорму(мдОбъекта.СтандартныеРеквизиты, "СтандартныеРеквизиты");
	
	// отделяем реквизиты для элементов и групп в справочниках и ПВХ.
	Если Метаданные.Справочники.Индекс(мдОбъекта) >= 0 ИЛИ Метаданные.ПланыВидовХарактеристик.Индекс(мдОбъекта) >= 0 Тогда
		МассивРеквизитов = Новый Массив;
		Для Каждого мдРеквизита из мдОбъекта.Реквизиты Цикл
			Если мдРеквизита.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппыИЭлемента ИЛИ
					ВыбСсылка.ЭтоГруппа И мдРеквизита.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппы ИЛИ
					Не ВыбСсылка.ЭтоГруппа И мдРеквизита.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляЭлемента Тогда
				МассивРеквизитов.Добавить(мдРеквизита);
			КонецЕсли;
		КонецЦикла;
		ДобавитьРеквизитыНаФорму(МассивРеквизитов, "РеквизитыОбъекта");
	Иначе
		ДобавитьРеквизитыНаФорму(мдОбъекта.Реквизиты, "РеквизитыОбъекта");
	КонецЕсли;
	
	Если Метаданные.ПланыСчетов.Индекс(мдОбъекта) >= 0 Тогда
		ДобавитьРеквизитыНаФорму(мдОбъекта.ПризнакиУчета, "ПризнакиУчёта");
	КонецЕсли;
	
	Для Каждого мдТабличнойЧасти из мдОбъекта.ТабличныеЧасти Цикл
		Если Метаданные.Справочники.Индекс(мдОбъекта) >= 0 ИЛИ Метаданные.ПланыВидовХарактеристик.Индекс(мдОбъекта) >= 0 Тогда
			Если мдТабличнойЧасти.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппыИЭлемента ИЛИ
					ВыбСсылка.ЭтоГруппа И мдТабличнойЧасти.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппы ИЛИ
					Не ВыбСсылка.ЭтоГруппа И мдТабличнойЧасти.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляЭлемента Тогда
				ДобавитьТабличнуюЧастьНаФорму(мдТабличнойЧасти);
			КонецЕсли;
		Иначе
			ДобавитьТабличнуюЧастьНаФорму(мдТабличнойЧасти);
		КонецЕсли;
	КонецЦикла;
	
	Если Метаданные.ПланыСчетов.Индекс(мдОбъекта) >= 0 или Метаданные.ПланыВидовРасчета.Индекс(мдОбъекта) >= 0 Тогда
		Для Каждого мдТабличнойЧасти из мдОбъекта.СтандартныеТабличныеЧасти Цикл
			ДобавитьТабличнуюЧастьНаФорму(мдТабличнойЧасти);
		КонецЦикла;
	КонецЕсли;
	
	// работаем с движениями
	ПрочитатьДвижения();
КонецПроцедуры

&НаКлиенте
Процедура ВыбСсылкаПриИзменении(Элемент)
	ПрочитатьОбъект();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ВыбСсылка = ХранилищеОбщихНастроек.Загрузить("УниверсальныйРедакторРеквизитов", "ВыбСсылка");
	ПростаяФормаВыбора = ХранилищеОбщихНастроек.Загрузить("УниверсальныйРедакторРеквизитов", "ПростаяФормаВыбора");
	ПоказыватьТолькоРегистрыСДвижениями = ХранилищеОбщихНастроек.Загрузить("УниверсальныйРедакторРеквизитов", "ПоказыватьТолькоРегистрыСДвижениями");
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ВыбСсылкаПриИзменении(Неопределено);
	ЧтоРедактируемПриСменеСтраницы(Элементы.ЧтоРедактируем, Элементы.ЧтоРедактируем.ТекущаяСтраница);
	
	// { Фрагмент, запрещённый к удалению или изменению
	ЭтаФорма.Элементы.УдалятьИлиИзменятьЗапрещено.Заголовок = "Организация неизбежности светлого будущего";
	// Фрагмент, запрещённый к удалению или изменению. lyay@yandex.ru }
КонецПроцедуры

&НаСервере
Процедура СохранитьНастройки()
	ХранилищеОбщихНастроек.Сохранить("УниверсальныйРедакторРеквизитов", "ВыбСсылка", ВыбСсылка);
	ХранилищеОбщихНастроек.Сохранить("УниверсальныйРедакторРеквизитов", "ПростаяФормаВыбора", ПростаяФормаВыбора);
	ХранилищеОбщихНастроек.Сохранить("УниверсальныйРедакторРеквизитов", "ПоказыватьТолькоРегистрыСДвижениями", ПоказыватьТолькоРегистрыСДвижениями);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	СохранитьНастройки()
КонецПроцедуры

// переносит строку из таблицы значений, правленной пользователем в строку табличной части объекта
&НаСервере
Процедура ПеренестиСтрокуТабличнойЧасти(СтрокаТЗ, СтрокаТЧ, мдТабличнойЧасти)
	Для каждого мдРеквизита Из мдТабличнойЧасти.СтандартныеРеквизиты Цикл
		мдОбъекта = ВыбСсылка.Метаданные();
		Если Метаданные.ПланыСчетов.Индекс(мдОбъекта) >= 0 И СтрокаТЗ.Предопределенное
			Или Метаданные.ПланыВидовРасчета.Индекс(мдОбъекта) >= 0  И СтрокаТЗ.Предопределенный Тогда
			Прервать // предопределённые строки редактировать нельзя
		КонецЕсли;
		Если мдРеквизита.Имя <> "Предопределенное" И мдРеквизита.Имя <> "Предопределенный" И мдРеквизита.Имя <> "Predefined"
			И мдРеквизита.Имя <> "НомерСтроки" И мдРеквизита.Имя <> "LineNumber" Тогда
			СтрокаТЧ[мдРеквизита.Имя] = СтрокаТЗ[мдРеквизита.Имя];
		КонецЕсли; 
	КонецЦикла; 
	
	// обычная табличная чать. Условие нужно потому что у стандартной табличной части нет Реквизитов есть только СтандартныеРеквизиты
	Если НЕ ТипЗнч(мдТабличнойЧасти) = Тип("ОписаниеСтандартнойТабличнойЧасти") Тогда
		Для каждого мдРеквизита Из мдТабличнойЧасти.Реквизиты Цикл
			Если Не мдРеквизита.Тип.СодержитТип(Тип("ХранилищеЗначения"))
				И мдРеквизита.Имя <> "НомерСтроки" И мдРеквизита.Имя <> "LineNumber" Тогда
				СтрокаТЧ[мдРеквизита.Имя] = СтрокаТЗ[мдРеквизита.Имя];
			КонецЕсли;
		КонецЦикла; 
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПеренестиТчСФормыВОбъект(ВыбОбъект, мдТабличнойЧасти)
	тз = РеквизитФормыВЗначение("lyayТч" + мдТабличнойЧасти.Имя);
	тч = ВыбОбъект[мдТабличнойЧасти.Имя];
	
	// Порядок записи изменений:
	// 1. составляем список строк, которые нужно перенести в объект
	// 2. строки не вошедшие в список удаляем из табличной части объекта
	// 3. переносим в объект изменивиеся строки
	// 4. добавляем в объект добавленные строки
	
	ОставляемыеСтроки = Новый Соответствие;
	Для каждого стр Из тз Цикл
		Если стр.НомерСтроки > 0 Тогда
			ОставляемыеСтроки.Вставить(тч[стр.НомерСтроки - 1], стр.НомерСтроки);
		КонецЕсли; 
	КонецЦикла;
	
	// удаляем строки, удалённые пользователем из тз
	поз = 0;
	Пока поз < тч.Количество() Цикл
		Если ОставляемыеСтроки[тч[поз]] = Неопределено Тогда // строки нет в списке оставляемых
			тч.Удалить(тч[поз]);
		Иначе
			поз = поз + 1;
		КонецЕсли; 
	КонецЦикла; 
	
	// переносим данные в тч
	// Сначала перенесём строки, которые пользователь оставил. Возможно отредактил, но оставил
	Для каждого зн Из ОставляемыеСтроки Цикл
		СтрокаТЗ = тз.Найти(зн.Значение, "НомерСтроки");
		ПеренестиСтрокуТабличнойЧасти(СтрокаТЗ, зн.Ключ, мдТабличнойЧасти);
	КонецЦикла; 
	
	// тепереь перенесём в тч добавленные строки
	мас = тз.НайтиСтроки(Новый Структура("НомерСтроки", 0));
	Для каждого СтрокаТз Из мас Цикл
		СтрокаТЧ = тч.Добавить();
		ПеренестиСтрокуТабличнойЧасти(СтрокаТЗ, СтрокаТЧ, мдТабличнойЧасти);
	КонецЦикла; 
КонецПроцедуры

&НаСервере
Процедура ЗаписатьОбъект()
	мдОбъекта = ВыбСсылка.Метаданные();
	ВыбОбъект = ВыбСсылка.ПолучитьОбъект();
	
	// Установим общие реквизиты
	Для Каждого мдРеквизита из Метаданные.ОбщиеРеквизиты Цикл
		ЭлементСоставаОбщегоРеквизита = мдРеквизита.Состав.Найти(мдОбъекта);
		Если ЭлементСоставаОбщегоРеквизита.Использование = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.Использовать или
			ЭлементСоставаОбщегоРеквизита.Использование = Метаданные.СвойстваОбъектов.АвтоИспользованиеОбщегоРеквизита.Использовать
			и мдРеквизита.АвтоИспользование = Метаданные.СвойстваОбъектов.АвтоИспользованиеОбщегоРеквизита.Использовать Тогда
			ВыбОбъект[мдРеквизита.Имя] = ЭтаФорма["lyay" + мдРеквизита.Имя];
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого мдРеквизита из мдОбъекта.СтандартныеРеквизиты Цикл
		Если НЕ (мдРеквизита.Имя = "Ссылка" или мдРеквизита.Имя = "Ref" ИЛИ мдРеквизита.Имя = "Предопределенный" или мдРеквизита.Имя = "Predefined"
			 ИЛИ мдРеквизита.Имя = "Проведен" ИЛИ мдРеквизита.Имя = "Posted" ИЛИ мдРеквизита.Имя = "ЭтоГруппа"  ИЛИ мдРеквизита.Имя = "IsFolder") Тогда
			ВыбОбъект[мдРеквизита.Имя] = ЭтаФорма["lyay" + мдРеквизита.Имя];
		КонецЕсли;
	КонецЦикла;

	// отделяем реквизиты для элементов и групп в справочниках и ПВХ.
	Если Метаданные.Справочники.Индекс(мдОбъекта) >= 0 ИЛИ Метаданные.ПланыВидовХарактеристик.Индекс(мдОбъекта) >= 0 Тогда
		Для Каждого мдРеквизита из мдОбъекта.Реквизиты Цикл
			Если Не мдРеквизита.Тип.СодержитТип(Тип("ХранилищеЗначения")) Тогда
				Если мдРеквизита.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппыИЭлемента ИЛИ
						ВыбСсылка.ЭтоГруппа И мдРеквизита.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппы ИЛИ
						Не ВыбСсылка.ЭтоГруппа И мдРеквизита.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляЭлемента Тогда
					ВыбОбъект[мдРеквизита.Имя] = ЭтаФорма["lyay" + мдРеквизита.Имя];
				КонецЕсли;
			КонецЕсли; 
		КонецЦикла;
	Иначе
		Для Каждого мдРеквизита из мдОбъекта.Реквизиты Цикл
			Если Не мдРеквизита.Тип.СодержитТип(Тип("ХранилищеЗначения")) Тогда
				ВыбОбъект[мдРеквизита.Имя] = ЭтаФорма["lyay" + мдРеквизита.Имя];
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	// Установим признаки учёта
	Если Метаданные.ПланыСчетов.Индекс(мдОбъекта) >= 0 Тогда
		Для Каждого мдРеквизита из мдОбъекта.ПризнакиУчета Цикл
			ВыбОбъект[мдРеквизита.Имя] = ЭтаФорма["lyay" + мдРеквизита.Имя];
		КонецЦикла;
	КонецЕсли;
	
	// Записываем табличные части
	// Сначала стандартные ТЧ для тех типов у кого они есть
	Если Метаданные.ПланыСчетов.Индекс(мдОбъекта) >= 0 или Метаданные.ПланыВидовРасчета.Индекс(мдОбъекта) >= 0 Тогда
		Для Каждого мдТабличнойЧасти из мдОбъекта.СтандартныеТабличныеЧасти Цикл
			ПеренестиТчСФормыВОбъект(ВыбОбъект, мдТабличнойЧасти);
		КонецЦикла;
	КонецЕсли;
	
	// Затем остальные ТЧ
	Для Каждого мдТабличнойЧасти из мдОбъекта.ТабличныеЧасти Цикл
		Если Метаданные.Справочники.Индекс(мдОбъекта) >= 0 ИЛИ Метаданные.ПланыВидовХарактеристик.Индекс(мдОбъекта) >= 0 Тогда
			Если мдТабличнойЧасти.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппыИЭлемента ИЛИ
					ВыбСсылка.ЭтоГруппа И мдТабличнойЧасти.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппы ИЛИ
					Не ВыбСсылка.ЭтоГруппа И мдТабличнойЧасти.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляЭлемента Тогда
				ПеренестиТчСФормыВОбъект(ВыбОбъект, мдТабличнойЧасти);
			КонецЕсли;
		Иначе
			ПеренестиТчСФормыВОбъект(ВыбОбъект, мдТабличнойЧасти);
		КонецЕсли;
	КонецЦикла;
	ВыбОбъект.ОбменДанными.Загрузка = РежимЗаписиЗагрузка;
	ВыбОбъект.Записать();
	
	ПрочитатьОбъект();
КонецПроцедуры

&НаСервере
Процедура ЗаписатьДвижения()
	мдОбъекта = ВыбСсылка.Метаданные();
	ВыбОбъект = ВыбСсылка.ПолучитьОбъект();
	Для каждого мдРегистра Из мдОбъекта.Движения Цикл
		Если Метаданные.РегистрыБухгалтерии.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРБ" + мдРегистра.Имя;
		ИначеЕсли Метаданные.РегистрыНакопления.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРН" + мдРегистра.Имя;
		ИначеЕсли Метаданные.РегистрыРасчета.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРР" + мдРегистра.Имя;
		ИначеЕсли Метаданные.РегистрыСведений.Содержит(мдРегистра) Тогда
			ИмяРеквизитаФормы = "lyayРС" + мдРегистра.Имя;
		КонецЕсли; 
		
		НаборЗаписей = ВыбОбъект.Движения[мдРегистра.Имя];
		НаборЗаписей.Прочитать();
		Если ПоказыватьТолькоРегистрыСДвижениями И НаборЗаписей.Количество() = 0 Тогда
			Продолжить
		КонецЕсли; 
		НаборЗаписей.ОбменДанными.Загрузка = РежимЗаписиЗагрузка;
		НаборЗаписей.Очистить();
		тзРеквизитФормы = РеквизитФормыВЗначение(ИмяРеквизитаФормы);
		НаборЗаписей.Загрузить(тзРеквизитФормы);
		НаборЗаписей.Записать();
	КонецЦикла; 
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИзменения(Команда)
	Если Элементы.ЧтоРедактируем.ТекущаяСтраница = Элементы.СодержаниеОбъекта Тогда
		ЗаписатьОбъект();
	ИначеЕсли Элементы.ЧтоРедактируем.ТекущаяСтраница = Элементы.Движения Тогда
		ЗаписатьДвижения();
	Иначе
		Сообщить("Э-э-э-э. Что-то не так.");
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура УдалитьОбъектНавсегда()
	ВыбОбъект = ВыбСсылка.ПолучитьОбъект();
	ВыбОбъект.Удалить();
	ВыбСсылка = Неопределено;
	ПрочитатьОбъект();
КонецПроцедуры
	
&НаКлиенте
Процедура УдалитьОбъект(Команда)
	Если Вопрос("Вы осознаёте ответственность за нарушение ссылочной целостности?
		|И действительно хотите НАВСЕГДА удалить " + Строка(ВыбСсылка) + " ?",
			РежимДиалогаВопрос.ДаНет,
			30,
			КодВозвратаДиалога.Нет,
			"Удалить навсегда?") <> КодВозвратаДиалога.Да Тогда
		Возврат
	КонецЕсли;
	УдалитьОбъектНавсегда();
КонецПроцедуры

&НаКлиенте
Процедура ВыбСсылкаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ПредыдущаяВыбСсылка = ВыбСсылка; // ВыбСсылка очищается при выборе типа. Странно, при СтандартнаяОбработка = Ложь такого не ждёшь.
	СтруктураПараметров = Новый Структура("ВыбСсылка", ПредыдущаяВыбСсылка);
	ФормаВыбораВида = ПолучитьФорму("ВнешняяОбработка.УниверсальныйРедакторРеквизитов.Форма.УправляемаяФормаВыбораВидаОбъекта",
												СтруктураПараметров,
												ЭтаФорма.Элементы.ВыбСсылка);
	ФормаВыбораВида.ЗакрыватьПриЗакрытииВладельца = Истина;
	ФормаВыбораВида.ЗакрыватьПриВыборе = Истина;
	РезультатВыбораТипа = ФормаВыбораВида.ОткрытьМодально(); // Вот тут очищается ВыбСсылка. Удивительно.
	Если РезультатВыбораТипа <> Неопределено Тогда
		Элемент.ОграничениеТипа = Новый ОписаниеТипов(РезультатВыбораТипа.Тип + "Ссылка." + РезультатВыбораТипа.Вид);
		ВыбСсылка = Элемент.ОграничениеТипа.ПривестиЗначение(ВыбСсылка);
		
		Если ПростаяФормаВыбора Тогда
			// форма выбора в конфигурации не подходит - используем собственную.
			СтруктураПараметров = Новый Структура("ВыбСсылка, ОписаниеТипа", ПредыдущаяВыбСсылка, РезультатВыбораТипа);
			ФормаВыбора = ПолучитьФорму("ВнешняяОбработка.УниверсальныйРедакторРеквизитов.Форма.УправляемаяФормаВыбораОбъекта",
														СтруктураПараметров,
														ЭтаФорма.Элементы.ВыбСсылка);
			ФормаВыбора.Открыть();
		Иначе
			ФормаВыбора = ПолучитьФорму(РезультатВыбораТипа.Тип + "." + РезультатВыбораТипа.Вид + ".ФормаВыбора", , ЭтаФорма.Элементы.ВыбСсылка);
			ФормаВыбора.Открыть();
		КонецЕсли; 
	Иначе
		ВыбСсылка = ПредыдущаяВыбСсылка;
	КонецЕсли;
КонецПроцедуры

// Предопределённые строки стандартной табличной части править нельзя
&НаКлиенте
Процедура ПередНачаломИзмененияСтандартнойТЧ(Элемент, Отказ)
	Предопределенное = Ложь;
	Если Элемент.ТекущиеДанные.Свойство("Предопределенное", Предопределенное) ИЛИ
		Элемент.ТекущиеДанные.Свойство("Предопределенный", Предопределенное) ИЛИ
		Элемент.ТекущиеДанные.Свойство("Predefined", Предопределенное) Тогда
		Отказ = Предопределенное = Истина;
	КонецЕсли;
	
	Если Не Отказ Тогда
		// Признак "Предопределённый" редактировать нельзя. А то пользователь галку поставит, и строка сразу станет недоступной
		Отказ = Прав(Элемент.ТекущийЭлемент.Имя, 16) = "Предопределенный" ИЛИ Прав(Элемент.ТекущийЭлемент.Имя, 16) = "Предопределенное" ИЛИ Прав(Элемент.ТекущийЭлемент.Имя, 10) = "Predefined";
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередНачаломДобавленияТЧ(Элемент, Отказ, Копирование, Родитель, Группа)
	// при копировнии нужно очистить некоторые реквизиты
	Если Копирование Тогда
		Если Элемент.ТекущиеДанные.Свойство("НомерСтроки") Тогда
			Элемент.ТекущиеДанные.НомерСтроки = 0;
		КонецЕсли;
		Если Элемент.ТекущиеДанные.Свойство("Предопределенное") Тогда
			Элемент.ТекущиеДанные.Предопределенное = Ложь;
		ИначеЕсли Элемент.ТекущиеДанные.Свойство("Предопределенный") Тогда
			Элемент.ТекущиеДанные.Предопределенный = Ложь;
		ИначеЕсли Элемент.ТекущиеДанные.Свойство("Predefined") Тогда
			Элемент.ТекущиеДанные.Predefined = Ложь;
		КонецЕсли;
	КонецЕсли; 
КонецПроцедуры

&НаКлиенте
Процедура ОбрабатыватьДвиженияПриИзменении(Элемент)
	ПрочитатьОбъект();
	//ПрочитатьДвижения();
КонецПроцедуры

&НаКлиенте
Процедура ЧтоРедактируемПриСменеСтраницы(Элемент, ТекущаяСтраница)
	Если ТекущаяСтраница.Имя = "СодержаниеОбъекта" Тогда
		Элементы.ЗаписатьИзменения.Заголовок = "Записать объект";
		Элементы.ЗаписатьИзменения.Доступность = Истина;
	ИначеЕсли ТекущаяСтраница.Имя = "Движения" Тогда
		Элементы.ЗаписатьИзменения.Заголовок = "Записать движения";
		Элементы.ЗаписатьИзменения.Доступность = Истина;
	Иначе
		Элементы.ЗаписатьИзменения.Доступность = Ложь;
	КонецЕсли; 
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьТолькоРегистрыСДвижениямиПриИзменении(Элемент)
	ПрочитатьОбъект();
КонецПроцедуры

// { Фрагмент, запрещённый к удалению или изменению
&НаКлиенте
Процедура УдалятьИлиИзменятьЗапрещено(Команда)
	ЗапуститьПриложение("http://onsb.org/");
КонецПроцедуры
// Разработка свободна. То есть поставляется с исходными кодами и может распространяться и использоваться бесплатно. Лицензионное соглашение можно прочесть тут http://code.google.com/p/gpl3rus/wiki/LatestRelease
// Дополнительные ограничения к лицензии:
// Изменение допускается при сохранении ссылки на автора, описании внесённых изменений. Коммерческое распространение запрещается.
// Также запрещается удалять или вносить изменения в фрагменты кода обозначенные комментиариями "Фрагмент, запрещённый к удалению или изменению".
// Нельзя изменять, скрывать или удалять элемент формы УдалятьИлиИзменятьЗапрещено
// Юрий Ляшко
// lyay@yandex.ru

// Фрагмент, запрещённый к удалению или изменению. }
