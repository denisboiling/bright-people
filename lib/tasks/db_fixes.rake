# encoding: utf-8
namespace :fixes do
  task :fix_age_tags => :environment do
    Activity.all.each do |activity|
      next unless activity.age_tags.present?
      ages = activity.age_tags.map {|a| [a.start_year,a.end_year]}.flatten.uniq
      start_age = ages.min
      end_age = ages.max
      activity.start_age = start_age || 0
      activity.end_age = end_age || 0
      activity.save
    end
  end

  task :bind_stations_and_regions => :environment do
    r = Region.where(:title => "Запад").first
    "Киевская,Парк Победы,Проспект Вернадского,Юго-Западная,Крылатское,Молодёжная,Кунцевская,Пионерская,Филёвский парк,Багратионовская,Фили,Кутузовская,Студенческая".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil?
      end
    end
    r = Region.where(:title => "Восток").first
    "Новогиреево,Перово,Шоссе Энтузиастов,Щёлковская,Первомайская,Измайловская,Партизанская,Семеновская,Электрозаводская,Улица Подбельского,Черкизовская,Преображенская площадь,Сокольники,Выхино".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil?
      end
    end
    r = Region.where(:title => "Центр").first
    "Рижская,Проспект Мира,Сухаревская,Тургеневская,Китай-город,Третьяковская,Октябрьская,Белорусская,Маяковская,Тверская,Театральная,Новокузнецкая,Павелецкая,Площадь Ильича,Марксистская,Третьяковская,Бауманская,Курская,Площадь Революции,Арбатская,Смоленская,Красносельская,Комсомольская,Красные ворота,Чистые пруды,Лубянка,Охотный ряд,Библиотека имени Ленина,Парк Культуры,Фрунзенская,Спортивная,Воробьёвы горы,Кропоткинская,Смоленская,Арбатская,Александровский сад,Проспект Мира,Комсомольская,Курская,Таганская,Павелецкая,Добрынинская,Октябрьская,Краснопресненская,Белорусская,Новослободская,Улица 1905 года,Баррикадная,Пушкинская,Кузнецкий мост,Китай-город,Пролетарская,Таганская,Менделеевская,Цветной бульвар,Чеховская,Боровицкая,Полянка,Серпуховская".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil?
      end
    end
    r = Region.where(:title => "Север").first
    "Речной вокзал,Водный стадион,Войковская,Сокол,Аэропорт,Динамо,Полежаевская,Беговая,Петровско-Разумовская,Тимирязевская".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil?
      end
    end
    r = Region.where(:title => "Северо-Восточный АО").first
    "ВДНХ,Медведково,Бабушкинская,Свиблово,Ботанический сад,Алексеевская,Алтуфьево,Бибирево,Отрадное,Владыкино,Дмитровская,Савёловская".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil? if m.nil?
      end
    end
    r = Region.where(:title => "Северо-Западный АО").first
    "Планерная,Сходненская,Тушинская,Щукинская,Октябрьское Поле".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil?
      end
    end
    r = Region.where(:title => "Юг").first
"Шаболовская,Автозаводская,Коломенская,Каширская,Кантемировская,Царицыно,Орехово,Домодедовская,Красногвардейская,Варшавская,Тульская,Нагатинская,Нагорная,Южная,Пражская,Улица Академика Янгеля,Аннино".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil?
      end
    end
    r = Region.where(:title => "Юго-Восток").first
    "Авиамоторная,Волгоградский проспект,Текстильщики,Кузьминки,Рязанский проспект,Дубровка,Кожуховская,Печатники,Волжская,Люблино,Братиславская,Марьино".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil?
      end
    end
    r = Region.where(:title => "Юго-Запад").first
    "Ленинский проспект,Академическая,Профсоюзная,Новые Черёмушки,Калужская,Беляево,Коньково,Тёплый Стан,Ясенево,Битцевский парк,Каховская,Университет,Нахимовский проспект,Севастопольская,Чертановская,Бульвар Дмитрия Донского".split(",").each do |ms|
      m = MetroStation.where(:title => ms).first
      if !m.nil? and m.region.nil?
        m.region = r
        m.save!
      else
        puts ms if m.nil?
      end
    end
  end
end
