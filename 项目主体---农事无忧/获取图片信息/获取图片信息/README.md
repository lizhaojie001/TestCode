获取图片内部信息
===

>原demo地址:<https://github.com/davidleee/GetExifInfoDemo>
>原创作者博客[Lee的笔记本](http://davidleee.com/2016/04/21/get-exif-from-image-ios/)
iOS10之后info.plist中添加访问相册的字段`Privacy - Photo Library Usage Description : 允许访问图册?`

**信息打印:**

```
{
    ColorModel = RGB;
    DPIHeight = 72;
    DPIWidth = 72;
    Depth = 8;
    Orientation = 1;
    PixelHeight = 2002;
    PixelWidth = 3000;
    ProfileName = "sRGB IEC61966-2.1";
    "{ExifAux}" =     {
        ImageNumber = 8458;
        LensID = 170;
        LensInfo =         (
            24,
            120,
            4,
            4
        );
        LensModel = "24.0-120.0 mm f/4.0";
        SerialNumber = 6001440;
    };
    "{Exif}" =     {
        ApertureValue = "6.643855776306108";
        ColorSpace = 1;
        ComponentsConfiguration =         (
            1,
            2,
            3,
            0
        );
        Contrast = 0;
        CustomRendered = 0;
        DateTimeDigitized = "2012:08:08 11:52:11";
        DateTimeOriginal = "2012:08:08 11:52:11";
        DigitalZoomRatio = 1;
        ExifVersion =         (
            2,
            3
        );
        ExposureBiasValue = 0;
        ExposureMode = 1;
        ExposureProgram = 1;
        ExposureTime = 4;
        FNumber = 10;
        FileSource = 3;
        Flash = 16;
        FlashPixVersion =         (
            1,
            0
        );
        FocalLenIn35mmFilm = 24;
        FocalLength = 24;
        FocalPlaneResolutionUnit = 4;
        FocalPlaneXResolution = "204.840206185567";
        FocalPlaneYResolution = "204.840206185567";
        GainControl = 0;
        ISOSpeedRatings =         (
            200
        );
        LightSource = 0;
        MaxApertureValue = 4;
        MeteringMode = 5;
        PixelXDimension = 3000;
        PixelYDimension = 2002;
        Saturation = 0;
        SceneCaptureType = 0;
        SensingMethod = 2;
        Sharpness = 0;
        ShutterSpeedValue = "-2";
        SubjectDistRange = 0;
        SubjectDistance = "2.99";
        SubsecTimeDigitized = 9;
        SubsecTimeOriginal = 9;
        WhiteBalance = 0;
    };
    "{GPS}" =     {
        Altitude = 103;
        GPSVersion =         (
            2,
            3,
            0,
            0
        );
        ImgDirection = "302.4";
        ImgDirectionRef = T;
        Latitude = "65.682895";
        LatitudeRef = N;
        Longitude = "17.54892833333333";
        LongitudeRef = W;
        MapDatum = "WGS-84";
        Speed = "1.6";
        SpeedRef = K;
    };
    "{IPTC}" =     {
        Byline =         (
            "Nicolas Cornet"
        );
        City = "Lj\U00f3savatn";
        CopyrightNotice = "Nicolas Cornet";
        "Country/PrimaryLocationName" = Iceland;
        DateCreated = 20120808;
        DigitalCreationDate = 20120808;
        DigitalCreationTime = 115211;
        ObjectName = Godafoss;
        "Province/State" = Northeast;
        SubLocation = Godafoss;
        TimeCreated = 115211;
    };
    "{TIFF}" =     {
        Artist = "Nicolas Cornet";
        Copyright = "Nicolas Cornet";
        DateTime = "2012:08:08 11:52:11";
        Make = "NIKON CORPORATION";
        Model = "NIKON D800E";
        Orientation = 1;
        ResolutionUnit = 2;
        Software = "Aperture 3.4.5";
        XResolution = 72;
        YResolution = 72;
    };
}

```