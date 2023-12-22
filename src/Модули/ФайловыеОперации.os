///////////////////////////////////////////////////////////////////////////////
//
// Служебный модуль с набором методов для работы с файлами
//
// (с) BIA Technologies, LLC
//
///////////////////////////////////////////////////////////////////////////////

// НовыйФайл
// Упрощает конструктор файлов, избавит от необходимости проверять значение
// Параметры:
//   ПутьИлиФайл - Строка или Файл	- Полный путь к файлу или сам файл.
// 		Если передан файл, вернется тот же объект 
//
//  Возвращаемое значение:
//   Файл - Файл
//
Функция НовыйФайл(ПутьИлиФайл) Экспорт
	
	Если ТипЗнч(ПутьИлиФайл) = Тип("Строка") Тогда 
		
		НовыйФайл = Новый Файл(ПутьИлиФайл);
	
	ИначеЕсли ТипЗнч(ПутьИлиФайл) = Тип("Файл") Тогда
	
		НовыйФайл = ПутьИлиФайл;
	
	Иначе
	
		ВызватьИсключение "Не удалось определить тип переданного параметра";
	
	КонецЕсли;

	Возврат НовыйФайл;
КонецФункции

// ПрочитатьТекстФайла
//	Возвращает содержимое файла, читая его в правильной кодировке
// Параметры:
//   ПутьКФайлу - Строка - Полный путь к файлу
//
//  Возвращаемое значение:
//   Строка - Содержимое файла
//
Функция ПрочитатьТекстФайла(ПутьКФайлу) Экспорт
	
	Кодировка	= ОпределитьКодировку(ПутьКФайлу);
	Текст		= Новый ЧтениеТекста();
	Текст.Открыть(ПутьКФайлу, Кодировка);
	
	СодержимоеФайла = Текст.Прочитать();
	
	Текст.Закрыть();
	
	Возврат СодержимоеФайла;
	
КонецФункции // ПрочитатьТекстФайла

// ЗаписатьТекстФайла
//	Определяет кодировку файла и записывает содержимое в файл
// 
// Параметры:
//	ПутьКФайлу 		- Строка - Полный путь к файлу
//	СодержимоеФайла	- Строка - Текст для записи
Процедура ЗаписатьТекстФайла(ПутьКФайлу, СодержимоеФайла) Экспорт
	
	Кодировка		= ОпределитьКодировку(ПутьКФайлу);
	ЗаписьТекста	= Новый ЗаписьТекста(ПутьКФайлу, Кодировка, , , Символы.ПС);
	
	ЗаписьТекста.Записать(СодержимоеФайла);
	ЗаписьТекста.Закрыть();
	
КонецПроцедуры // ЗаписатьТекстФайла

// ОпределитьКодировку
//	Читает первые 3 байта файла и ищет маркер BOM кодировки UTF-8
// Параметры:
//   ПутьКФайлу - Строка - Полный путь к файлу
//
//  Возвращаемое значение:
//   Перечисление - Кодировка файла
//
Функция ОпределитьКодировку(ПутьКФайлу) Экспорт
	
	МаркерUTFBOM	= СтрРазделить("239 187 191", " ");
	ЧтениеДанных	= Новый ЧтениеДанных(ПутьКФайлу);
	Буфер			= Новый БуферДвоичныхДанных(МаркерUTFBOM.Количество());
	
	ЧтениеДанных.ПрочитатьВБуферДвоичныхДанных(Буфер, , МаркерUTFBOM.Количество());
	Cч		= 0;
	ЕстьBOM	= Истина;
	
	Для Каждого Байт ИЗ Буфер Цикл
		
		Если МаркерUTFBOM[Cч] <> Строка(Байт) Тогда
			
			ЕстьBOM = Ложь;
			Прервать;
			
		КонецЕсли;
		
		Cч = Cч + 1;
		
	КонецЦикла;
	
	ЧтениеДанных.Закрыть();
	
	Возврат ?(ЕстьBOM, КодировкаТекста.UTF8, КодировкаТекста.UTF8NoBOM);
	
КонецФункции // ОпределитьКодировку

// Возвращает путь файла относительно корневого каталога
//
// Параметры:
//   ПутьКорневогоКаталога - Строка - путь корневого каталога
//   ПутьВнутреннегоФайла - Строка - путь файла
//   РазделительПути - Строка или Неопределено - все разделители в пути заменяются на указанный разделитель пути
//		если Неопределено, то разделители пути не заменяются
//
//  Возвращаемое значение:
//   Строка - относительный путь файла
//
Функция ОтносительныйПуть(Знач ПутьКорневогоКаталога, Знач ПутьВнутреннегоФайла, Знач РазделительПути = Неопределено) Экспорт

	ПроверитьКорневойКаталог(ПутьКорневогоКаталога);
	
	ФайлКорень = Новый Файл(ПутьКорневогоКаталога);
	ФайлВнутреннийКаталог = Новый Файл(ПутьВнутреннегоФайла);
	Рез = СтрЗаменить(ФайлВнутреннийКаталог.ПолноеИмя, ФайлКорень.ПолноеИмя, "");
	
	Если Найти("\/", Лев(Рез, 1)) > 0 Тогда
		Рез = Сред(Рез, 2);	
	КонецЕсли;

	Если Найти("\/", Прав(Рез, 1)) > 0 Тогда
		Рез = Лев(Рез, СтрДлина(Рез)-1);
	КонецЕсли;
	
	Если РазделительПути <> Неопределено Тогда
		Рез = СтрЗаменить(Рез, "\", РазделительПути);
		Рез = СтрЗаменить(Рез, "/", РазделительПути);
	КонецЕсли;

	Если ПустаяСтрока(Рез) Тогда
		Рез = ".";
	КонецЕсли;

	Возврат Рез;
КонецФункции

// Возвращает относительный путь файла по относительному пути, обрезая разделители. Приводит разделители пути к формату ОС
//
// Параметры:
//   ПутьКорневогоКаталога - Строка - путь корневого каталога
//   ОтносительныйПутьФайла - Строка - относительный путь в корне каталога
//
//  Возвращаемое значение:
//   Строка - относительный путь файла
//
Функция ПолучитьНормализованныйОтносительныйПуть(Знач ПутьКорневогоКаталога, Знач ОтносительныйПутьФайла) Экспорт
	
	ПроверитьКорневойКаталог(ПутьКорневогоКаталога);

	Разделитель = ПолучитьРазделительПути();
	ОтносительныйПутьФайла = НормализоватьРазделители(ОтносительныйПутьФайла);
	Если СтрНачинаетсяС(ОтносительныйПутьФайла, Разделитель) Тогда
		ОтносительныйПутьФайла = Сред(ОтносительныйПутьФайла, 2);
	КонецЕсли;
	Если СтрЗаканчиваетсяНа(ОтносительныйПутьФайла, Разделитель) Тогда
		ОтносительныйПутьФайла = Лев(ОтносительныйПутьФайла, СтрДлина(ОтносительныйПутьФайла) - 1);
	КонецЕсли;

	ПолныйПутьФайла = ОбъединитьПути(ПутьКорневогоКаталога, ОтносительныйПутьФайла);
	ОтносительныйПуть = ОтносительныйПуть(ПутьКорневогоКаталога, ПолныйПутьФайла, Разделитель);
	Файл = Новый Файл(ПолныйПутьФайла);
	ЭтоКаталог = Файл.Существует() И Файл.ЭтоКаталог();
	Результат = ?(ЭтоКаталог, ОтносительныйПуть + Разделитель, ОтносительныйПуть);
	
	Возврат Результат;

КонецФункции

// Возвращает полный путь файла по относительному пути, обрезая лишние разделители, приводит разделители пути к формату ОС
//
// Параметры:
//   ПутьКорневогоКаталога - Строка - путь корневого каталога
//   ОтносительныйПутьФайла - Строка - относительный путь в корне каталога
//
//  Возвращаемое значение:
//   Строка - полный путь файла
//
Функция ПолучитьНормализованныйПолныйПуть(Знач ПутьКорневогоКаталога, Знач ОтносительныйПутьФайла) Экспорт
	
	ПроверитьКорневойКаталог(ПутьКорневогоКаталога);

	ОтносительныйПуть = ПолучитьНормализованныйОтносительныйПуть(ПутьКорневогоКаталога, ОтносительныйПутьФайла);
	Результат = ОбъединитьПути(ПутьКорневогоКаталога, ОтносительныйПуть);
	
	Возврат Результат;

КонецФункции


Функция НайтиКаталоги(Путь) Экспорт

	МассивКаталогов = Новый Массив;
	
	ФайлКаталога = Новый Файл(Путь);
	
	Если ФайлКаталога.Существует() И ФайлКаталога.ЭтоКаталог() Тогда
		
		МассивФайлов = НайтиФайлы(ФайлКаталога.ПолноеИмя, "*");
	
		Для Каждого Файл Из МассивФайлов Цикл
			
			Если Файл.ЭтоКаталог() Тогда 
				
				МассивКаталогов.Добавить(Файл);
				
			КонецЕсли;

		КонецЦикла;
		
	КонецЕсли;
	
	Возврат МассивКаталогов;

КонецФункции

Функция КаталогСуществует(Знач Путь1, Знач Путь2 = Неопределено, Знач Путь3 = Неопределено, Знач Путь4 = Неопределено) Экспорт

	ПолныйПуть = ОбъединитьПути(Путь1, Путь2, Путь3, Путь4);

	Файл = Новый Файл(ПолныйПуть);
	Возврат Файл.Существует() И Файл.ЭтоКаталог();
	
КонецФункции

Функция НормализоватьРазделители(Путь) Экспорт
	#Если Windows Тогда
		Возврат СтрЗаменить(Путь, "/", "\");
	#Иначе
		Возврат СтрЗаменить(Путь, "\", "/");
	#КонецЕсли
КонецФункции

Процедура ПроверитьКорневойКаталог(ПутьКорневогоКаталога)
	
	Если ПустаяСтрока(ПутьКорневогоКаталога) Тогда
		
		ВызватьИсключение "Не указан корневой путь в методе ОтносительныйПуть";
		
	КонецЕсли;

КонецПроцедуры
