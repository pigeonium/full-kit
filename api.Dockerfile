FROM python:3.10-slim

RUN pip install fastapi "uvicorn[standard]" mysql-connector-python ecdsa asteval requests

COPY ./pigeonium /app/server/pigeonium
COPY ./server /app/server

COPY <<EOF /app/server/config.py
import os

class Server:
    Host: str = "0.0.0.0"
    Port: int = 14540
    RootPath: str = "/api"

class MySQL:
    host: str = os.getenv("MYSQL_HOST", "localhost")
    user: str = "pigeonium"
    password: str = "password"
    database: str = "pigeonium"

class Pigeonium:
    NetworkName: str = "Pigeonium"
    NetworkId: int = 0
    ContractDeployCost: int = 100
    ContractExecutionCost: int = 10
    InputDataCost: int = 10
    Decimals: int = 6

    AdminPrivateKey: bytes = bytes.fromhex(os.getenv("ADMIN_PRV_KEY", bytes(32).hex()))
    AdminPublicKey: bytes = bytes.fromhex(os.getenv("ADMIN_PUB_KEY", bytes(64).hex()))

    from pigeonium.currency import Currency
    BaseCurrency = Currency()
    BaseCurrency.currencyId = bytes(16)
    BaseCurrency.name = "Pigeon"
    BaseCurrency.symbol = "Pigeon"
    BaseCurrency.issuer = bytes.fromhex(os.getenv("BASE_CU_ISSUER", bytes(16).hex()))
    BaseCurrency.supply = 1000000_000000
EOF

# パスを追加
ENV PYTHONPATH /app
ENV PYTHONPATH /app/server

CMD ["python3","/app/server/main.py"]