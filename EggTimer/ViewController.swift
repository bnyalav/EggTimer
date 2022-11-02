
import UIKit
import AVFoundation //ses eklemek için kütüphane çapırma

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7] //yumurtaların pişme süresi
    
    var player: AVAudioPlayer? //ses için değişken ekle
    var secondsRemaining = 60 //saniye ataması
    var timer = Timer() //değişken ataması
    var totalTime = 0 //toplam süre değişkeni
    var secondsPassed = 0 //geçen süre değişkeni
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate() //timer geçersiz kıl
        let hardness = sender.currentTitle! //sertlik basılan butona eşittir
        totalTime = eggTimes[hardness]! //total time değerini basılan tuşa göre değiştir
        
        progressBar.progress = 0.0 //seçimde progressi sıfırla
        secondsPassed = 0 //seçimde geçen süreyi sıfırla
        titleLabel.text = hardness //seçimi labela yazdır
            
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true) //selector fonksiyonla aynı olmalı
        
    }
    @objc func updateTimer() {
        if secondsPassed <  totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime)) //çalışılabilirliği görmek için
            //geçen süre total zamandan küçükse geçen süreyi 1 arttır
            //progress bar görünümünü geçen süre / total süre yap
            
        }
        else if secondsPassed == totalTime{
            timer.invalidate()
            titleLabel.text = "Your egg Ready"
            playSound() //geçen süre total süreye eşitlendiğinde sesi çal
            //geçen süre total süreye eşitse timer durdur ve labela yazı yaz
        }
    }
    //how to play a sound using swift stack overflow
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}
