# -*- coding: utf-8 -*-
ActiveAdmin.register FestivalCategory do
  menu label: "Категории", :parent => "Фото модуль"

  index do
    column :title
    default_actions
  end

  form do |f|
    f.inputs "Основное" do
      f.input :title
      f.input :path, as: :select, collection: (FestivalCategory.top.keep_if { |a| a != f.object }).map { |m| [m.title, m.id] }
    end
    f.buttons
  end

end