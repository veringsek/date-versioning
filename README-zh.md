# 日期版本

> English [中文](README-zh.md)

基於日期設計的版本控制模式。

## 規格

日期版本適用於任何可以更名的檔案或資料夾。

此文中僅會提到檔案，但對於資料夾，所有邏輯都是完全相同的。以下提到的檔案名稱並不包含副檔名。檔案名稱與副檔名結合起來會稱為檔案的全名。

考慮一個檔案，全名為 `${name}${ext}` ，其中 `${name}` 是檔案名稱， `${ext}` 是包含 `.` 的副檔名，若檔案沒有副檔名，這個字串就是空的。

在建立日期版本時，將版本插入到檔案名稱與副檔名中間，並以空格減號空格 ` - ` 隔開名稱與版本:

```
${name} - ${version}${ext}
```

版本 `${version}` 由版本代號 `${code}` 和版本描述 `${desc}` 組成。

版本代號是由日期 `${date}` 和一個流水號 `${sn}` 連結而成，中間會用底線連接。

日期基本上就是版本建立的日期，一般來說格式為 `YYYY-MM-DD` ，其中 `YYYY` 是年， `MM` 是兩位數的月， `DD` 是兩位數的日。

要注意的是，日期並不一定要使用公元，也不一定要使用格里曆。在我的環境中使用的是中華民國曆，因此我在日期版本中使用的也是中華民國曆。

流水號從 0 開始數。不必補零，因為流水號理論上沒有上限。不過實際上流水號很難超過 99（若超過，表示你在一天之內對同一個檔案建立了上百個版本），因此要補成兩位數也不是不行。

版本描述可以是空的，若不是空的，必須以底線 `_` 起頭，其後可以隨便紀錄任何東西，不過建議將其中的空格全部換成底線。

檔案最終的全名會像是

```
${name} - ${date}${sn}${desc}${ext}
```

僅當流水號為零且沒有版本描述的時候，兩者 `${sn}` 和 `{desc}` 可以同時被省略，變成

```
${name} - ${date}${ext}
```

以下為正確的範例：

|    | Original    | Date Version                             |
|:--:|:------------|:-----------------------------------------|
| ⭕ | report.docx | report - 2022-07-01_0.docx               |
| ⭕ | report.docx | report - 2022-07-01.docx                 |
| ⭕ | report.docx | report - 2022-07-01_1_amy_modified.docx  |
| ⭕ | report.docx | report - 2022-07-01_1_final_version.docx |
| ⭕ | report.docx | report - 2022-07-01_23_究極最終版.docx    |

## Indentity

Two Date Versions are identified as the same version if they share the same version code. They can have different version description, but the version code must be the same iff they're the same version.

When comparing, omitted serial number 0 is still considered serial number 0, which means `report - 2022-07-01.docx` and `report - 2022-07-01_0_audit.docx` are the same Date Version. The description `audit` is only a note, it's not like "an audit version of `report - 2022-07-01_0.docx` ", it's more like the `report - 2022-07-01.docx` omitted the description, probably because the creator thought it was not worth noting. But as Date Versioning spec indicated, these two files must have identical content and be considered the same version.

If you want to create an audit version of `report - 2022-07-01_0.docx` , you should create another Date Version, for example, `report - 2022-07-01_1.docx` .

The file without Date Version is the working one, which should be the latest one.

## Why

* Why use Date Versioning?

  It's easy to tell when the version was created.

  It's easy to create a Date Version without any tool. Just copy and change the name.

  It's quick. No setup is required.

  It's scalable. You can use Date Versioning on a single file. You can use Date Versioning on a directory with a bunch of files inside. You can also use Date Versioning on a specific file in that Date Versioned directory.

* When not to use Date Versioning?

  When you can use Git. Git is convenient. Git allows cooperation. Git works with version difference. Git is storage efficient.

  When you need to cooperate with others on the same file, which means more than one person can create versions of that file, you must not use Date Versioning.

* When to use Date Versioning?

  When setting-up Git is too complex. Like an Excel `.xlsx` file with students' exam scores. Setting-up Git for this only file is too many work, and not that useful like text files.

  When you want to quickly create a version, you can choose Date Versioning over Git.

* Why use space-dash-space ` - ` between name and version?

  Because that is how Explorer name a clone file automatically under Windows. A clone to file `name.ext` will be named `name - Copy.ext` . The earliest Date Versioning is to copy a file, and replace the `Copy` part with a date. With Chinese as the system language, only 2 characters need to be replace because the clone will be named `name - 複製.ext` by Explorer.

  Furthermore, the spaces aside the dash clearly split the `${name}` and `${version}` apart, making it easier to distinguish visually.

* Why use underscore `_` between date and serial number in version code?

  With underscore and without spaces, the date and serial number is linked, making them looks like one thing.

  The reason not to use dash is to distinquish serial number from the day of month in date, because dash is used between month and day.

* Why copy?

  Because it, in most cases, allows you to create a Date Version while working with that file.

## Automation

## License

[MIT](http://opensource.org/licenses/MIT)

Copyright © 2022, veringsek