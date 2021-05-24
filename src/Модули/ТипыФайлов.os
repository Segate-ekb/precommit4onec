///////////////////////////////////////////////////////////////////////////////
//
// Служебный модуль с набором методов для определения типа файла
//
// (с) BIA Technologies, LLC
//
///////////////////////////////////////////////////////////////////////////////

// ЭтоФайлИсходников
//	Возвращает истину, если файл является файлом исходных кодов
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлИсходников(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Расширение, ".bsl") = 0;
	
КонецФункции

// ЭтоФайлОписанияКонфигурации
//	Возвращает истину, если файл является файлом описания конфигурации
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлОписанияКонфигурации(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Имя, "Configuration.xml") = 0;
	
КонецФункции

// ЭтоФайлОписанияКонфигурацииEDT
//	Возвращает истину, если файл является файлом описания конфигурации в формате EDT
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлОписанияКонфигурацииEDT(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Имя, "Configuration.mdo") = 0;
	
КонецФункции

// ЭтоФайлОбычнойФормы
//	Возвращает истину, если файл является файлом обычной формы
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлОбычнойФормы(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Имя, "Form.bin") = 0;
	
КонецФункции // ЭтоФайлОбычнойФормы

// ЭтоФайлОписанияМетаданных
//	Возвращает истину, если файл является описанием метаданных, исключая файлы описания конфигурации.
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлОписанияМетаданных(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат ЭтоФайлОписанияМетаданныхКонфигуратора(Файл) ИЛИ ЭтоФайлОписанияМетаданныхEDT(Файл);
	
КонецФункции // ЭтоФайлОписанияМетаданных

// ЭтоФайлОписанияМетаданныхКонфигуратора
//	Возвращает истину, если файл является описанием метаданных конфигуратора, исключая Configuration.xml
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлОписанияМетаданныхКонфигуратора(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Если ЭтоФайлОписанияКонфигурации(Файл) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Расширение, ".xml") = 0;
	
КонецФункции // ЭтоФайлОписанияМетаданныхКонфигуратора

// ЭтоФайлОписанияМетаданныхEDT
//	Возвращает истину, если файл является описанием метаданных конфигуратора, исключая Configuration.mdo
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлОписанияМетаданныхEDT(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Если ЭтоФайлОписанияКонфигурацииEDT(Файл) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Расширение, ".mdo") = 0;
	
КонецФункции // ЭтоФайлОписанияМетаданныхEDT

// ЭтоФайлОписанияФормы
//	Возвращает истину, если файл является файлом описания формы
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлОписанияФормы(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Имя, "Form.xml") = 0;
	
КонецФункции

// ЭтоФайлОписанияФормыEDT
//	Возвращает истину, если файл является файлом описания формы в формате EDT
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
//  Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлОписанияФормыEDT(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Имя, "Form.form") = 0;
	
КонецФункции

// ЭтоФайлЧастьТеста
//	Возвращает истину, если файл относится к тестовому расширению
// Параметры:
//   Файл - Файл - Полный путь к файлу
//   КаталогРепозитория - Строка - Путь к репозиторию, для более точного определения принадлежности, необязательный
//
// Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоФайлЧастьТеста(Файл, КаталогРепозитория = Неопределено) Экспорт
	
	ПутьКФайлу = НРег(ПолучитьОтносительныйПуть(Файл.Путь, КаталогРепозитория));
	
	Возврат СтрНайти(ПутьКФайлу, СтрШаблон("%1tests%1", ПолучитьРазделительПути())) <> 0;
	
КонецФункции

// ЭтоОбщийМодуль
//	Возвращает истину, если файл является общим модулем
// Параметры:
//   Файл - Файл - Полный путь к файлу
//   КаталогИсходныхФайлов - Строка - Путь к исходникам, для более точного определения принадлежности, необязательный
//
// Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоОбщийМодуль(Файл, КаталогИсходныхФайлов = Неопределено) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	ПутьКФайлу = НРег(ПолучитьОтносительныйПуть(Файл.Путь, КаталогИсходныхФайлов));
	
	Возврат СтрСравнить(Файл.Имя, "Module.bsl") = 0
		И СтрНайти(ПутьКФайлу, СтрШаблон("%1commonmodules%1", ПолучитьРазделительПути())) <> 0;
	
КонецФункции

// ЭтоМодульМенеджера
//	Возвращает истину, если файл является модулем менеджера
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
// Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоМодульМенеджера(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Имя, "ManagerModule.bsl") = 0;
	
КонецФункции

// ЭтоМодульОбъекта
//	Возвращает истину, если файл является модулем объекта
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
// Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоМодульОбъекта(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Имя, "ObjectModule.bsl") = 0;
	
КонецФункции

// ЭтоМодульНабораЗаписей
//	Возвращает истину, если файл является модулем набора записей
// Параметры:
//   Файл - Файл - Полный путь к файлу
//
// Возвращаемое значение:
//   Булево - Признак
//
Функция ЭтоМодульНабораЗаписей(Файл) Экспорт
	
	Если ПустаяСтрока(Файл.Расширение) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат СтрСравнить(Файл.Имя, "RecordSetModule.bsl") = 0;
	
КонецФункции

Функция ПолучитьОтносительныйПуть(Путь, Надкаталог)
	
	Результат = Путь;
	
	Если Не ЗначениеЗаполнено(Надкаталог) Тогда
		Возврат Результат;
	КонецЕсли;
	
	ДлинаПутиНадкаталога = СтрДлина(Надкаталог);
	Если СтрСравнить(Надкаталог, Лев(Путь, ДлинаПутиНадкаталога)) = 0 Тогда
		
		Результат = Сред(Путь, ДлинаПутиНадкаталога + 1);
		
		Если Не СтрНачинаетсяС(Результат, ПолучитьРазделительПути()) Тогда
			
			Результат = ПолучитьРазделительПути() + Результат;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
