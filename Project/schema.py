from sqlalchemy import Column, Integer, String, DateTime, func
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class URL(Base):
    __tablename__ = 'URL'

    id = Column(Integer, primary_key=True, autoincrement=True)
    original_url = Column(String(30), nullable=False)
    shorten_url = Column(String(30), nullable=False)
    submit_date = Column(DateTime, default=func.now())
    expire_date = Column(DateTime)
    views = Column(Integer, default=0)
