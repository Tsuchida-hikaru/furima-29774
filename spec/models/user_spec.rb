require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいく時' do
      it '全ての項目にバリデーション通りの記入がされているとき、登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上' do
        @user.password = "123abc"
        @user.password_confirmation = "123abc"
        expect(@user).to be_valid
      end
      it 'nicknameに全角ひらがな・カタカナ・漢字・英字・数字が使用されている' do
        @user.nickname = "あア亜ａ１"
        expect(@user).to be_valid
      end
      it 'first_nameに全角ひらがな・カタカナ・漢字が使用されている' do
        @user.first_name = "あア亜"
        expect(@user).to be_valid
      end
      it 'family_nameに全角ひらがな・カタカナ・漢字が使用されている' do
        @user.family_name = "あア亜"
        expect(@user).to be_valid
      end
      it 'furigana_first_nameに全角カタカナが使用されている' do
        @user.furigana_first_name = "ア"
        expect(@user).to be_valid
      end
      it 'furigana_family_nameに全角カタカナが使用されている' do
        @user.furigana_family_name = "ア"
        expect(@user).to be_valid
      end
      it '適切な値が入力された時、情報が受け入れられエラーメッセージは表示されない' do
      end
    end

    context '新規登録がうまくいかない時' do
      it 'nicknameが空' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '同じemailの二重登録' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれていない' do
        @user.email = "emailgoogle.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下' do
        @user.password = "12345"
        @user.password_confirmation = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角英字のみ' do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input half-size alphabet and numeral only.")
     end
      it 'passwordが半角数字のみ' do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input half-size alphabet and numeral only.")
      end
      it 'passwordに半角英数字以外の文字が使われている' do
        @user.password = "1あ3ｱ5亜!"
        @user.password_confirmation = "1あ3ｱ5亜!"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input half-size alphabet and numeral only.")
      end
      it '確認用の2回目のpassword記入欄が空' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '確認用の2回目のpassword記入欄が1回目と相違している' do
        @user.password = "abc456"
        @user.password_confirmation = "abc4567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'first_nameが空' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameに全角英字が使われている' do
        @user.first_name = "ＡＢＣ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it 'first_nameに全角数字が使われている' do
        @user.first_name = "１２３４５"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it 'first_nameに半角カタカナが使われている' do
        @user.first_name = "ｱｲｳｴｵ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it 'first_nameに半角英字が使われている' do
        @user.first_name = "abcdefg"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it 'first_nameに半角数字が使われている' do
        @user.first_name = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it 'family_nameが空' do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'family_nameに全角英字が使われている' do
        @user.family_name = "ａｂｃ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end
      it 'family_nameに全角数字が使われている' do
        @user.family_name = "１２３４５"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end
      it 'family_nameに半角カタカナが使われている' do
        @user.family_name = "ｱｲｳｴｵ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end
      it 'family_nameに半角英字が使われている' do
        @user.family_name = "abcde"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end
      it 'family_nameに半角数字が使われている' do
        @user.family_name = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end
      it 'furigana_first_nameが空' do
        @user.furigana_first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name can't be blank")
      end
      it 'furigana_first_nameに全角ひらがなが使われている' do
        @user.furigana_first_name = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_first_nameに漢字が使われている' do
        @user.furigana_first_name = "亜居兎絵尾"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_first_nameに全角英字が使われている' do
        @user.furigana_first_name = "ａｉｕｅｏ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_first_nameに全角数字が使われている' do
        @user.furigana_first_name = "１２３４５"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_first_nameに半角カタカナが使われている' do
        @user.furigana_first_name = "ｱｲｳｴｵ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_first_nameに半角英字が使われている' do
        @user.furigana_first_name = "aiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_first_nameに半角数字が使われている' do
        @user.furigana_first_name = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_family_nameが空' do
        @user.furigana_family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name can't be blank")
      end
      it 'furigana_family_nameに全角ひらがなが使われている' do
        @user.furigana_family_name = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_family_nameに漢字が使われている' do
        @user.furigana_family_name = "亜居兎絵尾"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_family_nameに全角英字が使われている' do
        @user.furigana_family_name = "ａｉｕｅｏ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_family_nameに全角数字が使われている' do
        @user.furigana_family_name = "１２３４５"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_family_nameに半角カタカナが使われている' do
        @user.furigana_family_name = "ｱｲｳｴｵ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_family_nameに半角英字が使われている' do
        @user.furigana_family_name = "aiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name is invalid. Input full-width katakana characters.")
      end
      it 'furigana_family_nameに半角数字が使われている' do
        @user.furigana_family_name = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name is invalid. Input full-width katakana characters.")
      end
      it 'birthdayが空' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'birthdayに全角ひらがなが使われている' do
        @user.birthday = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid. Input half-size numerical character.")
      end
      it 'birthdayに全角カタカナが使われている' do
        @user.birthday = "アイウエオ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid. Input half-size numerical character.")
      end
      it 'birthdayに漢字が使われている' do
        @user.birthday = "亜居兎絵尾"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid. Input half-size numerical character.")
      end
      it 'birthdayに全角英字が使われている' do
        @user.birthday = "ａｉｕｅｏ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid. Input half-size numerical character.")
      end
      it 'birthdayに全角数字が使われている' do
        @user.birthday = "１２３４５６"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid. Input half-size numerical character.")
      end
      it 'birthdayに半角カタカナが使われている' do
        @user.birthday = "ｱｲｳｴｵ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid. Input half-size numerical character.")
      end
      it 'birthdayに半角英字が使われている' do
        @user.birthday = "aiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid. Input half-size numerical character.")
      end
      it 'birthdayに"-"以外の記号が使われている' do
        @user.birthday = "2000/01/01"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid. Input half-size numerical character.")
      end
      it '適切ではない値が入力された時、情報は受け入れられずエラーメッセージが表示される' do
      end
    end
  end

  describe 'ログイン時' do
    

  end
end
