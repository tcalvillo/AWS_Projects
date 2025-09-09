# main.py
import sys
from PyQt5.QtWidgets import QApplication, QMainWindow
from PyQt5.QtGui import QPainter, QPixmap
from PyQt5.QtCore import pyqtSignal, QObject
from ui_main import Ui_MainWindow
from team import Team
from match_engine import simulate_match

class Communicate(QObject):
    simulate_match_signal = pyqtSignal()

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.bg = QPixmap("resources/serie_d.jpg")

        # Debug print to check if the image is loaded
        print("Image loaded successfully:", not self.bg.isNull())

        self.communicate = Communicate()
        self.communicate.simulate_match_signal.connect(self.run_match)

        # Use UI as central widget
        central = Ui_MainWindow()
        self.setCentralWidget(central)

        # Connect the signal
        central.simulate_match_signal = self.communicate.simulate_match_signal

        # Access UI widgets
        self.label = central.label
        self.text_box = central.text_box

        # Resize to a larger default size
        self.resize(2048, 1536)

        # Teams
        self.team1 = Team("Asti")
        self.team2 = Team("Biellese")
        self.label.setText(f"{self.team1.name} vs {self.team2.name}")

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.drawPixmap(self.rect(), self.bg)
        super().paintEvent(event)

    def run_match(self):
        result, events = simulate_match(self.team1, self.team2)
        text = result + "\n\n" + "\n".join(events)
        self.text_box.setPlainText(text)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
