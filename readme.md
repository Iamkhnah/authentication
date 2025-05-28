# 🔐 Luau Key System Library

## 🇻🇳 Tiếng Việt

**Đây là một thư viện Luau (exploit)** giúp bạn tạo hệ thống key nhanh chóng thông qua **API Key của Link4m**, mà không cần phải tự làm backend hay quản lý nhiều thứ phức tạp.

### ✅ Ưu điểm của Link4m:
- Không thể bypass
- Hỗ trợ thanh toán qua **PayPal**, **ngân hàng Việt Nam**, **Momo**
- Dễ sử dụng, tích hợp nhanh

### 🚀 Cách dùng:

```lua
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Iamkhnah/authentication/refs/heads/main/main/script.luau"))()

lib:Start({
    ["Title"] = <string>,       -- Tên script của bạn
    ["Discord"] = <string>,     -- Link mời vào Discord
    ["Api Key"] = <string>,     -- API key từ link4m.co
    ["Script"] = <function>     -- Code bạn muốn chạy sau khi xác thực
})
```
## 🇺🇸 English

This is a **Luau library for exploit scripts** that allows you to implement a **Link4m-based key system** quickly and easily using your **Link4m API Key**. You don’t need to build your own backend or handle complex authentication logic.

### ✅ Why use Link4m?
- **Bypass-proof** key system
- Supports payments via **PayPal**, **Vietnamese banks**, and **Momo**
- Fast and simple integration
- Monetize your script securely

### 🚀 How to Use

```lua
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Iamkhnah/authentication/refs/heads/main/main/script.luau"))()

lib:Start({
    ["Title"] = "Your Script Name",           -- Name of your script
    ["Discord"] = "https://discord.gg/your",  -- Your Discord invite link
    ["Api Key"] = "your-link4m-api-key",      -- Your Link4m API Key
    ["Script"] = function()
        -- Your main script goes here
        print("Authenticated successfully!")
    end
})
```
📌 Notes
- Make sure you have an active Link4m account and API Key: https://link4m.co

- The user must complete the Link4m shortened URL to receive the key

- This script is designed for exploit environments such as KRNL, Synapse X, etc.
[Click here to get example](https://github.com/Iamkhnah/authentication/blob/main/main/example.lua)
