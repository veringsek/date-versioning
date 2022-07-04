# Date Versioning

> English [中文](README-zh.md)

A date-based versioning for casual files.

## Spec

Date Versioning applies to any files or directories, as long as they have a modifiable name. 

In the article below, only file will be mentioned, but the exact same logic applies to any directories. When talking about file names, extension is not included. The concat of file name and extension will be refered as full name.

Considering a file, with its full name as `${name}${ext}` , where `${name}` is the file's name, and `${ext}` is its extension including the leading `.` character, or empty if the file doesn't have an extension.

While creating a Date Version of the said file, insert version between the file name and the extension, with space-dash-space ` - ` splitting name and version, forming:

```
${name} - ${version}${ext}
```

The `${version}` consists of version code `${code}` and version description `${desc}` .

The version code is the concat of a date `${date}` and a serial number `${sn}` , with an underscore in between.

The date is usually when that version is created, normally it would be in format `YYYY-MM-DD` , where `YYYY` is year, `MM` is month in 2-digit, `DD` is day of month in 2-digit. 

Let it be known that the date is not necessarily in Common Era, not even necessarily in Gregorian calendar. In my environment, we use Republic of China calendar, so I also use that for my date in Date Versioning.

The serial number is counted from 0. It's recommended not to use zero padding on serial number, since the number is theoretically limited at infinity. But since the number is really hard to surpass 99 (if you surpass 99, it means you created at least a hundred of the versions of the same file in one day) , you can pad it to 2-digit if you really care so much.

The version description can be empty. When not empty, it must starts with underscore `_` . You can write down anything in version description, but it's recommended to replace all spaces with underscores.

So the final full name will be like

```
${name} - ${date}${sn}${desc}${ext}
```

Only when serial number is 0 and there's no version description, `${sn}` and `{desc}` can be omitted, forming

```
${name} - ${date}${ext}
```

Here's some examples:

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

Run [ `date-versioning.ps1` ](date-versioning.ps1) to quickly create Date Version:

```powershell
PS C:\> "date-versioning.ps1" "$file"
```

where `$file` is the file to create Date Version.

The script detects existing Date Version in the same directory to `$file` , and determine serial number automatically.

Use [ `install.ps1` ](install.ps1) on Windows to install the script as a context menu item `Make a Date Version` in Explorer. You can specify language when installing, with default as English.

```powershell
PS C:\> "install.ps1" -lang zh
```

Uninstall with [ `uninstall.ps1` ](uninstall.ps1).

## License

[MIT](http://opensource.org/licenses/MIT)

Copyright © 2022, veringsek
