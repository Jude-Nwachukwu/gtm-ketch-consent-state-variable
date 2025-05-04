# Ketch Consent State – GTM Custom Variable Template

This Google Tag Manager (GTM) custom variable template allows you to access user consent preferences set via the [Ketch](https://www.ketch.com/) Consent Management Platform (CMP). It’s especially useful when:

- Ketch is installed directly on your website (not via GTM).
- You want to configure GTM tags based on user consent signals.
- You are implementing **Basic or Advanced Consent Mode**.
- You want to define **exception triggers** based on specific consent categories.


> Developed by **Jude Nwachukwu Onyejewe** for [DumbData](https://dumbdata.co/)

---

## 🛠️ How to Use This Template


## 📦 Import the Template

1. Open Google Tag Manager.
2. Go to **Templates** → **Variable Templates**.
3. Click the **New** button and select **Import**.
4. Upload the `.tpl` file for this template.
## 🎛️ Configuration Options

### 1. **Select Consent State Check Type**

Use the **“Select Consent State Check Type”** dropdown to determine how the variable behaves:

- **All Consent State Check** – Returns an object of predefined consent categories and their current values.
- **Specific Consent State** – Returns the value of a single selected consent category.

### 2. **Select Ketch Consent Category**

(Visible when **Specific Consent State** is selected)

Choose from a list of predefined categories, such as:

- `security_storage`
- `ad_storage`
- `analytics_storage`
- `data_sharing`
- `targeted_advertising`
- *...and more*

Or select **“custom consent category”** to enter your own custom key using the **“Enter Consent Category”** field.

### 3. **Enable Optional Output Transformation**

Toggle this checkbox to convert raw consent values into tag-friendly formats.

#### Sub-options include:

- **Transform “True”**:
  - `granted`
  - `accept`

- **Transform “False”**:
  - `denied`
  - `deny`

- **Also transform “undefined” to “denied”**: Useful when a consent category is missing or not yet initialized.

## 🧰 Use Cases

- Controlling tag execution based on consent signals
- Using Ketch with GTM’s **Consent Mode**
- Creating trigger exceptions for marketing, analytics, or personalization tags
- Dynamically referencing custom Ketch consent keys

---

> 📦 This template bridges your GTM deployment with Ketch consent signals—ensuring compliance and control even when Ketch isn’t loaded via GTM.
