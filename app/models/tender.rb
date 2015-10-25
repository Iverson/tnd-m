class Tender < ActiveRecord::Base
  COLUMNS = ["№ п/п",  "Индивидуальный номер в системе Seldon", "Название процедуры закупки", "Наименование заказчика", "Этапы работ (из ТЗ, КП, ПД, КД)", "Ссылка на процедуру закупки",
   "Дата начала приема заявок", "Дата окончания приема заявок", "Начальная максимальная цена, руб.", "Срок предоставления документов в  КО для участия в процедуре закупки",
   "Срок утверждения Карточки проекта PRE-SALE", "Срок окончания работ", "Комментарии"]

  ATTRIBUTES = ["id", "seldon_id", "name", "customer", "milestones", "url", "start_date", "end_date", "start_max_price", "docs_deadline", "approve_deadline", "completion_date"]

  has_many :comments, as: :commentable

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << COLUMNS
      all.each_with_index do |tender, index|
        values = tender.attributes.values_at(*ATTRIBUTES)
        values[0] = index+1

        comments = [];
        tender.comments.each do |comment|
          comments << "#{comment.user.name} #{comment.created_at.strftime("%d %B %Y, %H:%M")} \n#{comment.message}"
        end

        values << comments.join("\n\n")

        csv << values
      end
    end
  end
end
