# ui_main.py
from PyQt5.QtWidgets import QWidget, QVBoxLayout, QLabel, QTextEdit, QPushButton, QHBoxLayout, QMenuBar, QMenu
from PyQt5.QtCore import Qt

class Ui_MainWindow(QWidget):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Mini Football Manager")

        # Main layout
        layout = QVBoxLayout(self)

        # Create a menu bar
        self.menu_bar = QMenuBar()

        # Create a menu
        menu = QMenu("Menu", self.menu_bar)

        # Add the "Simulate Match" button as a menu action
        simulate_action = menu.addAction("Simulate Match")
        simulate_action.triggered.connect(self.simulate_match_clicked)

        # Add the menu to the menu bar
        self.menu_bar.addMenu(menu)

        # Add the menu bar to the layout
        layout.setMenuBar(self.menu_bar)

        # Label
        self.label = QLabel("Team A vs Team B")
        layout.addWidget(self.label)

        # Text Box
        self.text_box = QTextEdit()
        self.text_box.setReadOnly(True)
        layout.addWidget(self.text_box)

        # Apply stylesheet with larger menu
        self.setStyleSheet("""
            QTextEdit {
                background: rgba(255, 255, 255, 200);
                font-size: 14px;
            }
            QLabel {
                color: white;
                font-size: 18px;
                font-weight: bold;
            }
            QMenuBar {
                background: rgba(0, 0, 0, 150);
                color: white;
                font-size: 36px;  /* 10 times bigger font */
                spacing: 20px;
                padding: 10px;
            }
            QMenuBar::item {
                padding: 10px 20px;
            }
            QMenu {
                background: rgba(0, 0, 0, 150);
                color: white;
                font-size: 24px;
            }
            QMenu::item:selected {
                background: rgba(50, 50, 50, 200);
            }
        """)

    def simulate_match_clicked(self):
        if hasattr(self, 'simulate_match_signal'):
            self.simulate_match_signal.emit()
