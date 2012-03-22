class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :votes
  validates_presence_of :text, :role_type, :category, :user
  validates_inclusion_of :role_type, :in => %Q{truth dare}, :message => "Only truth or dare."

  scope :truth, where(['role_type = ?', 'truth']).order('created_at DESC')
  scope :dare, where(['role_type = ?', 'dare']).order('created_at DESC')

  def truth?
    role_type == "truth"
  end

  def dare?
    role_type == "dare"
  end

  def headline
    return "#{user.name} fez uma pergunta sobre #{category.name} aos candidatos a vereador do Rio" if truth?
    return "#{user.name} fez uma demanda de #{category.name} aos candidatos a vereador do Rio" if dare?
  end
end
