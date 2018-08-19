class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :tweets
    #dependent_destroy => apagar um conta, apaga todos os dependentes, todos os seguidores.
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    #source => fonte de onde eu vou obter os dados
    has_many :followers, through: :active_relationships, source: :followed
    has_many :followeds, through: :passive_relationships, source: :follower

    #def following(other_user)
    	#Este método checa se um usuário está seguindo o outro
    #end

   # def follow!(other_user)
    	#Este método criará o relacionamento

end
