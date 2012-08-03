# encoding: utf-8
class AddDataChangeOrgKomitetPage < ActiveRecord::Migration
  def change
    levashova=Page.new
    levashova.permalink='levashova'
    levashova.text = "<!-- HTML HERE -->"
    levashova.save!
    muntyan=Page.new
    muntyan.permalink='muntyan'
    muntyan.text = "<!-- HTML HERE -->"
    muntyan.save!
    galperina=Page.new
    galperina.permalink='galperina'
    galperina.text = "<!-- HTML HERE -->"
    galperina.save!
    org = Page.as('org_komitet')
    org.text = '<div class="common">
	<div class="post_category_menu">
		<ul>
                  <li class="about_ico"><a href="/pages/about_festival">О фестивале</a></li>
                  <li class="creative_ico"><a href="/creative_group">Творческая группа</a></li>
                  <li class="participants_ico"><a href="/participants?category=music_stage">Программа</a></li>
                  <li class="headliners_ico "><a href="/participants">Хэдлайнеры</a></li>
                  <li class="org_ico active"><a href="/pages/org_komitet">Оргкомитет</a></li>
                  <li class="org_ico"><a href="/pages/inf">Инфопартнёры</a></li>
                </ul>
		<div class="clear">
		</div>
	</div>
	<div class="orgkomitet">
		<div class="org_people">
			<div class="org_people_preview">
				<div class="org_people_wrapper">
                    <a href="/pages/levashova" style="text-decoration: none;">
					<div class="thumb">
						<span class="mask"></span><img src="/assets/org_com_face_1.jpg" width="205px" height="205px" alt="" />
					</div>
					<span class="name">Надежда Левашова</span><span class="info">МОСКОВСКИЙ КРЕДИТНЫЙ БАНК</span>
                    </a>
				</div>
			</div>
			<div class="org_people_preview">
				<div class="org_people_wrapper">
                    <a href="/pages/muntyan" style="text-decoration: none;">
					<div class="thumb">
						<span class="mask"></span><img src="/assets/org_com_face_2.jpg" width="205px" height="205px" alt="" />
					</div>
					<span class="name">Ольга Мунтян</span><span class="info">КОМПАНИЯ "БРАЙТ ПИПЛ"</span>
                    </a>
				</div>
			</div>
			<div class="org_people_preview">
				<div class="org_people_wrapper">
                    <a href="/pages/galperina" style="text-decoration: none;">
					<div class="thumb">
						<span class="mask"></span><img src="/assets/org_com_face_3.jpg" width="205px" height="205px" alt="" />
					</div>
					<span class="name">Мария Гальперина</span><span class="info">КОМПАНИЯ "БРАЙТ ПИПЛ"</span>
                    </a>
				</div>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="title">
			 Оргкомитет фестиваля "Яркие люди 2012"
		</div>
		<div class="left_part">
			<div class="other_people_preview">
				<div class="thumb">
					<span class="mask"></span><img src="/assets/org_com_face_4.jpg" width="85" height="85" alt="" />
				</div>
				<div class="info">
					<div class="name">
						 Василиса Никифорова
					</div>
					 PR-менеджер проекта.

					 Обращаться по вопросам аккредитации журналистов.
					<div class="contact">
						<span class="toemail">vgn@massovet.ru</span><br>

						<span class="phone">+7 906 072-04-42</span>
					</div>
				</div>
			</div>
		</div>
		<div class="right_part">
			<div class="other_people_preview">
				<div class="thumb">
					<span class="mask"></span><img src="/assets/org_com_face_5.jpg" width="85" height="85" alt="" />
				</div>
				<div class="info">
					<div class="name">
						 Александра Сиснёва
					</div>
					 Продюсер проекта.

					 Обращаться по вопросам участия в фестивале.
					<div class="contact">
						<span class="toemail">sisneva@bright-people.ru</span><br>

<span class="phone">+7 916 552-70-72</span>
					</div>
				</div>
			</div>
		</div>
		<div class="clear">
		</div>
	</div>
</div>'
    org.save!
  end
end
