# 资源管理器

### 简介

本示例展示了在eTS中如何调用资源管理的API接口实现字符串和图片资源信息的获取。实现效果如下：

![main](sceenshots/device/main.png)

### 相关概念

资源管理：资源管理模块，根据当前configuration（语言，区域，横竖屏，mccmnc）和device capability（设备类型，分辨率）提供获取应用资源信息读取接口。

### 相关权限

不涉及。

### 使用说明

1.应用界面中展示了资源管理API各类接口的调用，包括读取的字符串、字符串数组、根据指定数量获取指定ID字符串表示的单复数字符串，指定资源ID对应的媒体文件内容字节数、指定资源ID对应的图片资源Base64编码字符串的长度，以及获取设备状态和设备支持的能力。

### 约束与限制

1.本示例仅支持标准系统上运行。

2.本示例需要使用DevEco Studio 3.0 Beta4 (Build Version: 3.0.0.992, built on July 14, 2022)才可编译运行。