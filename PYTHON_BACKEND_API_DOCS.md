# Humo Kids — Python Backend (FastAPI / Django) Integratsiya Qo'llanmasi

Ushbu qo'llanma **Humo Kids** Flutter mobil ilovasini **Python backend** bilan ulash uchun to'liq texnik xususiyatlar, endpointlar va tayyor FastAPI boshlang'ich shablonini o'z ichiga oladi.

---

## 1. Tarmoq Konfiguratsiyasi (Base URL)

Flutter ilovasi `lib/core/api/api_config.dart` orqali quyidagi standart manzillardan foydalanadi:

| Qurilma / Muhit | Base URL | Izoh |
|---|---|---|
| **Android Emulyator** | `http://10.0.2.2:8000/api/v1` | `10.0.2.2` kompyuterning `localhost`iga ulaydi |
| **iOS Simulyator** | `http://127.0.0.1:8000/api/v1` | Simulyator kompyuter bilan bitta tarmoqda |
| **Real Telefon (Wi-Fi)** | `http://<KOMPYUTER_IP>:8000/api/v1` | Masalan: `http://192.168.1.15:8000/api/v1` |
| **Web / Desktop** | `http://localhost:8000/api/v1` | Brauzer / MacOS |
| **Production Server** | `https://api.humokids.uz/api/v1` | SSL/HTTPS bilan |

> **Eslatma:** Real telefondan ulanishda Python serverni `0.0.0.0` hostida ishga tushiring:
> ```bash
> uvicorn main:app --host 0.0.0.0 --port 8000 --reload
> ```

---

## 2. CORS (Cross-Origin Resource Sharing)

Python backendda (ayniqsa Web va ilova uchun) CORS ga ruxsat berish shart:

```python
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

---

## 3. Autentifikatsiya (JWT Bearer Token)

- Kirishdan so'ng Flutter ilovasi `Authorization: Bearer <access_token>` sarlavhasini barcha so'rovlarga avtomatik ravishda qo'shadi.
- Tokenlar `SharedPreferences` da xavfsiz saqlanadi.

---

## 4. API Endpointlar va Ma'lumotlar Formati

### 4.1. Autentifikatsiya (Auth)

#### 1. OTP kod yuborish
- **Metod:** `POST /api/v1/auth/send-otp`
- **Request Body:**
```json
{
  "phone": "+998901234567"
}
```
- **Response (200 OK):**
```json
{
  "success": true,
  "message": "Tasdiqlash kodi yuborildi"
}
```

#### 2. OTP kodni tekshirish va Token olish
- **Metod:** `POST /api/v1/auth/verify-otp`
- **Request Body:**
```json
{
  "phone": "+998901234567",
  "code": "1234"
}
```
- **Response (200 OK):**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsIn...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsIn...",
  "token_type": "bearer",
  "user": {
    "id": "user_123",
    "name": "Dilnoza Abdullayeva",
    "phone": "+998901234567",
    "email": "dilnoza@example.com",
    "role": "parent",
    "has_pin": true
  }
}
```

#### 3. PIN-kod o'rnatish
- **Metod:** `POST /api/v1/auth/set-pin`
- **Header:** `Authorization: Bearer <token>`
- **Request Body:**
```json
{
  "pin": "1234"
}
```
- **Response (200 OK):**
```json
{
  "success": true,
  "message": "PIN-kod muvaffaqiyatli saqlandi"
}
```

#### 4. PIN-kod bilan kirish
- **Metod:** `POST /api/v1/auth/verify-pin`
- **Request Body:**
```json
{
  "pin": "1234"
}
```
- **Response (200 OK):**
```json
{
  "valid": true
}
```

#### 5. Foydalanuvchi profili
- **Metod:** `GET /api/v1/auth/me`
- **Header:** `Authorization: Bearer <token>`
- **Response (200 OK):**
```json
{
  "id": "user_123",
  "name": "Dilnoza Abdullayeva",
  "phone": "+998901234567",
  "role": "parent",
  "has_pin": true
}
```

---

### 4.2. Farzandlar va Bog'cha (Children)

#### 1. Farzandlar ro'yxati
- **Metod:** `GET /api/v1/children`
- **Header:** `Authorization: Bearer <token>`
- **Response (200 OK):**
```json
[
  {
    "id": "child_1",
    "name": "Amirbek",
    "group_name": "1-kichik guruh (Qaldirg'och)",
    "kindergarten_name": "№48 \"Yulduzcha\" MTM",
    "age": 4,
    "is_in_kindergarten": true,
    "arrival_time": "08:15 da kelgan"
  },
  {
    "id": "child_2",
    "name": "Yasmina",
    "group_name": "2-o'rta guruh (Kapalak)",
    "kindergarten_name": "№48 \"Yulduzcha\" MTM",
    "age": 5,
    "is_in_kindergarten": true,
    "arrival_time": "08:20 da kelgan"
  }
]
```

#### 2. Farzandning kunlik hisoboti
- **Metod:** `GET /api/v1/children/{child_id}/daily-report?date=2026-10-23`
- **Header:** `Authorization: Bearer <token>`
- **Response (200 OK):**
```json
{
  "child_id": "child_1",
  "date": "2026-10-23",
  "mood": "A'lo",
  "sleep_duration": "2 soat 15 daqiqa",
  "meals_score": "100%",
  "activities_completed": "4 ta mashg'ulot",
  "teacher_comment": "Amirbek bugun rasm chizish darsida juda faol bo'ldi."
}
```

#### 3. Kunlik taomnoma (Menyu)
- **Metod:** `GET /api/v1/children/{child_id}/food-menu`
- **Header:** `Authorization: Bearer <token>`
- **Response (200 OK):**
```json
[
  {
    "id": "meal_1",
    "meal_type": "Ertalabki nonushta",
    "time": "08:30 - 09:00",
    "title": "Suli yormasi (Kasha) va sut",
    "description": "Yangi pishirilgan suli yormasi, sariyog' va asal bilan",
    "calories": "280 kkal",
    "is_completed": true
  },
  {
    "id": "meal_2",
    "meal_type": "Tushlik",
    "time": "12:30 - 13:15",
    "title": "Frikadelkali sho'rva va grechka",
    "description": "Mol go'shtidan kotlet, barra sabzavotlar",
    "calories": "450 kkal",
    "is_completed": true
  }
]
```

---

### 4.3. To'lovlar (Payments)

#### 1. Invoyslar (To'lov talabnomalari)
- **Metod:** `GET /api/v1/payments/invoices`
- **Header:** `Authorization: Bearer <token>`
- **Response (200 OK):**
```json
[
  {
    "id": "inv_101",
    "child_id": "child_1",
    "child_name": "Amirbek",
    "month": "Oktabr 2026",
    "amount": 600000.0,
    "amount_formatted": "600 000 so'm",
    "status": "pending",
    "deadline": "28-oktabr 2026"
  }
]
```

#### 2. Saqlangan bank kartalari
- **Metod:** `GET /api/v1/payments/cards`
- **Header:** `Authorization: Bearer <token>`
- **Response (200 OK):**
```json
[
  {
    "id": "card_1",
    "card_number": "8600 **** **** 4589",
    "card_holder": "DILNOZA ABDULLAYEVA",
    "expire_date": "08/28",
    "type": "uzcard",
    "is_default": true
  },
  {
    "id": "card_2",
    "card_number": "9860 **** **** 1204",
    "card_holder": "DILNOZA ABDULLAYEVA",
    "expire_date": "11/27",
    "type": "humo",
    "is_default": false
  }
]
```

#### 3. Yangi karta qo'shish
- **Metod:** `POST /api/v1/payments/cards/add`
- **Body:** `{"card_number": "9860...", "expire_date": "12/28", "card_holder": "..."}`

#### 4. To'lov o'tkazish
- **Metod:** `POST /api/v1/payments/pay`
- **Body:**
```json
{
  "invoice_id": "inv_101",
  "card_id": "card_1",
  "provider": "Payme",
  "amount": 600000.0
}
```
- **Response (200 OK):**
```json
{
  "success": true,
  "transaction_id": "tx_998877",
  "message": "To'lov muvaffaqiyatli amalga oshirildi"
}
```

---

## 5. Sinov uchun Tezkor FastAPI Shablon (`backend_demo.py`)

Python dasturchisi backendni darhol sinab ko'rishi uchun minimal test kodi:

```python
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional, List

app = FastAPI(title="Humo Kids Backend API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class PhoneRequest(BaseModel):
    phone: str

class OtpVerifyRequest(BaseModel):
    phone: str
    code: str

class PinRequest(BaseModel):
    pin: str

@app.get("/api/v1/health")
def health_check():
    return {"status": "ok", "app": "Humo Kids Backend"}

@app.post("/api/v1/auth/send-otp")
def send_otp(req: PhoneRequest):
    return {"success": True, "message": f"{req.phone} raqamiga kod yuborildi"}

@app.post("/api/v1/auth/verify-otp")
def verify_otp(req: OtpVerifyRequest):
    return {
        "access_token": "mock_jwt_token_humo_kids_2026",
        "token_type": "bearer",
        "user": {
            "id": "1",
            "name": "Dilnoza Abdullayeva",
            "phone": req.phone,
            "role": "parent",
            "has_pin": True,
        }
    }

@app.post("/api/v1/auth/verify-pin")
def verify_pin(req: PinRequest):
    return {"valid": True}

@app.get("/api/v1/children")
def get_children():
    return [
        {
            "id": "child_1",
            "name": "Amirbek",
            "group_name": "1-kichik guruh",
            "kindergarten_name": "№48 \"Yulduzcha\" MTM",
            "age": 4,
            "is_in_kindergarten": True,
            "arrival_time": "08:15 da kelgan",
        },
        {
            "id": "child_2",
            "name": "Yasmina",
            "group_name": "2-o'rta guruh",
            "kindergarten_name": "№48 \"Yulduzcha\" MTM",
            "age": 5,
            "is_in_kindergarten": True,
            "arrival_time": "08:20 da kelgan",
        }
    ]

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("backend_demo:app", host="0.0.0.0", port=8000, reload=True)
```

Ishga tushirish:
```bash
pip install fastapi uvicorn
python backend_demo.py
```

