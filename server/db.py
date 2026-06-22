"""
Database connection module for ClinicaDB.
Reads connection parameters from the project's .env file.
"""
import os
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv

# Load .env from the parent directory (project root)
load_dotenv(os.path.join(os.path.dirname(__file__), '..', '.env'))

DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'port': os.getenv('DB_PORT', '5432'),
    'user': os.getenv('DB_USER_SECRET', 'admin'),
    'password': os.getenv('DB_PASSWORD_SECRET', 'david123'),
    'dbname': os.getenv('DB_NAME_SECRET', 'ClinicaDB'),
}


def get_connection():
    """Create and return a new database connection."""
    return psycopg2.connect(**DB_CONFIG)


def fetch_all(query, params=None):
    """Execute a SELECT query and return all rows as list of dicts."""
    conn = get_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params)
            rows = cur.fetchall()
            return [dict(row) for row in rows]
    finally:
        conn.close()


def fetch_one(query, params=None):
    """Execute a SELECT query and return a single row as dict."""
    conn = get_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params)
            row = cur.fetchone()
            return dict(row) if row else None
    finally:
        conn.close()


def execute(query, params=None):
    """Execute an INSERT/UPDATE/DELETE query and commit."""
    conn = get_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params)
            conn.commit()
            # Try to return the affected row (for INSERT ... RETURNING)
            try:
                row = cur.fetchone()
                return dict(row) if row else None
            except psycopg2.ProgrammingError:
                return None
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()
