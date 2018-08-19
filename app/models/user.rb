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
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

    def following?(other_user)
    	# Este método checa se um usuário está seguindo o outro
    	following.include? other_user
    end

    def follow!(other_user)
    	# Este método criará o relacionamento entre um usuário e outro
    	# following << other_user == following.push other_user (outro método de criar um recionamento)
    	active_relationships.create(followed: other_user)
    end

    def unfollow!(other_user)
    	# Este método apagará o relacionamento entre um usuário e outro 
    	# following.destroy  other_user idem ao comando de baixo
    	following.destroy(other_user)
    end

    def feed
    	# Este método irá gerar o feed para o usuário
    	users_ids = following.pluck(:id)
    	users_ids << self.id 
    	Tweet.where(user_id: users_ids).order(created_at: :desc)
    end

end
