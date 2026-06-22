import threading
import webview
from app import app


def run_server():
    app.run(host='127.0.0.1', port=3000, debug=False, use_reloader=False)


if __name__ == '__main__':
    server_thread = threading.Thread(target=run_server, daemon=True)
    server_thread.start()

    webview.create_window(
        'ClinicaDB Desktop',
        'http://127.0.0.1:3000/screen',
        width=1280,
        height=820,
        resizable=True
    )
    webview.start()
