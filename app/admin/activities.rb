# -*- coding: utf-8 -*-
ActiveAdmin.register Activity do
  menu label: 'Кружки', :parent => "Кружки, организации"

  scope :all, :default => true
  scope :educationals
  scope :entertainments
  scope :published
  scope :not_published

  controller do
    # TODO: create for this awesome module dude
    def autocomplete
      a = Activity.search(:conditions => {:title => params[:term]})
      render json: a.map{|x| {id: x.id, label: x.title, value: x.title}}.to_json
    end

    # Get gategories by is_educational?
    def get_categories
      @categories = DirectionTag.where(is_educational: params[:is_educational])
      render partial: 'get_categories'
    end
  end

  filter :title, as: :autocomplete, input_html: {'data-autocomplete' => '/admin/activities/autocomplete', object: 'activity'}

  index do
    id_column
    column :title do |activity|
      link_to activity.title, activity_path(activity)
    end
    column :address
    column :users_rating
    default_actions
  end

  form partial: "form"

  show do
    attributes_table :id, :title, :published, :address, :organization,
                     :users_rating, :created_at, :updated_at

    panel 'Станции метро' do
      activity.metro_station.map(&:title)
    end

    panel 'Посмотреть страницу' do
      link_to activity.title, activity_path(activity), target: '_blank'
    end

    panel 'Описание' do
      simple_format activity.description
    end

    panel 'Дополнительная информация' do
      simple_format activity.additional_information
    end

    panel 'Чем заняться родителю' do
      simple_format activity.parent_activities
    end

    panel 'Стоимость и длительность' do
      simple_format activity.cost
    end

    panel 'Карта' do
      form do |f|
        input class: 'hidden_coords', value: activity.coords, type: 'hidden'
      end
      div id: 'edit_map' do
      end
    end
  end
end
