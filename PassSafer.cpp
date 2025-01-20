#include "PassSafer.h"

PassSafer::PassSafer(QObject *parent)
{
	std::fstream fileCheck(this->FILENAME);

	if (fileCheck.fail())
	{
		//std::cout << "File does not exists" << std::endl;
		this->isFileExist = false;
	}
	else
	{
		//std::cout << "File is good" << std::endl;
		this->isFileExist = true;
	}

	srand(time(0));
	
}
PassSafer::~PassSafer()
{
	if(this->isSavingToFile == true)
		this->writeDataToFile(this->FILENAME);
}

int PassSafer::readDataFromFile(const char* filename)
{
	try {
		std::ifstream json_open_file(filename, std::ios::binary);

		if (json_open_file)
		{

			char* data_ptr_str = new char[this->SIZE_DATA_STR];
			memset(data_ptr_str, '\0', this->SIZE_DATA_STR);

			json_open_file.read(reinterpret_cast<char*>(data_ptr_str), this->SIZE_DATA_STR);
		
			//		Decrypt
			char* plaintext = new char[this->SIZE_DATA_STR];
			memset(plaintext, '\0', this->SIZE_DATA_STR);
			int plaintext_len;

			size_t file_size = std::filesystem::file_size(filename);

			if (this->DecryptAES((const unsigned char *)data_ptr_str, file_size, (unsigned char*)plaintext, plaintext_len) == false)
			{
				return -1;
			}

			plaintext[plaintext_len] = '\0';

			std::string str_data = (char *)plaintext;
			delete[] plaintext;
			delete[] data_ptr_str;

			if (str_data == "null")
                return 1;
                //throw  "Null json data";

			try
			{
				this->data = nlohmann::json::parse(str_data);
			}
			catch (nlohmann::json::parse_error& ex)
			{
				throw "Invalid json data";
			}

			json_open_file.close();
			return 1;
		}
		else
		{
			json_open_file.close();
			this->data.clear();
			return 0;
		}
	}
	catch (const char *except)
	{
		this->data.clear();
		
		return -1;
	}
}

int PassSafer::writeDataToFile(const char* filename)
{
	try {
		std::ofstream json_open_file(filename, std::ios::binary | std::ios::trunc);

		std::string json_text = this->data.dump();

		//	Encrypt
		char* encrypted_str = new char[this->SIZE_DATA_STR];
		memset(encrypted_str, '\0', this->SIZE_DATA_STR);
		int encrypted_str_len;

		if (this->EncryptAES((const unsigned char*)json_text.c_str(), json_text.length(), (unsigned char *)encrypted_str, encrypted_str_len) == false)
		{
			return -1;
		}

		//json_open_file.write(json_text.c_str(), json_text.length());
		json_open_file.write((const char*)encrypted_str, encrypted_str_len);

		delete[] encrypted_str;
		json_open_file.close();

		return 1;
	}
	catch (const char* except)
	{
		return -1;
	}
}

bool PassSafer::EncryptAES(const unsigned char* plaintext, int plaintext_len, unsigned char* ciphertext, int& ciphertext_len)
{
	EVP_CIPHER_CTX* ctx = EVP_CIPHER_CTX_new();
	if (!ctx)
		return false;

	if (EVP_EncryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, (const unsigned char*)this->key.c_str(), (const unsigned char*)this->iv) != 1)
	{
		EVP_CIPHER_CTX_free(ctx);
		return false;
	}

	int len;

	if (EVP_EncryptUpdate(ctx, ciphertext, &len, plaintext, plaintext_len) != 1)
	{
		EVP_CIPHER_CTX_free(ctx);
		return false;
	}

	ciphertext_len = len;

	if (EVP_EncryptFinal_ex(ctx, ciphertext + len, &len) != 1)
	{
		EVP_CIPHER_CTX_free(ctx);
		return false;
	}
	ciphertext_len += len;

	EVP_CIPHER_CTX_free(ctx);
	return true;
}

bool PassSafer::DecryptAES(const unsigned char* ciphertext, int ciphertext_len, unsigned char* plaintext, int& plaintext_len)
{
	EVP_CIPHER_CTX* ctx = EVP_CIPHER_CTX_new();
	if (!ctx)
		return false;

	if (EVP_DecryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, (const unsigned char*)this->key.c_str(), (const unsigned char*)this->iv) != 1)
	{
		EVP_CIPHER_CTX_free(ctx);
		return false;
	}

	int len;

	if (EVP_DecryptUpdate(ctx, plaintext, &len, ciphertext, ciphertext_len) != 1)
	{
		EVP_CIPHER_CTX_free(ctx);
		return false;
	}

	plaintext_len = len;
	//plaintext[plaintext_len] = '\0';

	if (EVP_DecryptFinal_ex(ctx, plaintext + len, &len) != 1)
	{
		EVP_CIPHER_CTX_free(ctx);
		return false;
	}
	plaintext_len += len;

	EVP_CIPHER_CTX_free(ctx);
	return true;
}



int PassSafer::CreateCard(const QString &TitleQ, const QString &PasswordQ, const QString &EmailQ ,  const QString &DescriptionQ )
{
    std::string Title = TitleQ.toStdString();
    std::string Password = PasswordQ.toStdString();
    std::string Email = EmailQ.toStdString();
    std::string Description = DescriptionQ.toStdString();

	if (this->data.size() >= this->MAX_CARDS_COUNT)
		return -1;

	if (Title.length() == 0 || Title.length() >= this->TITLE_SIZE)
		return -1;

	if (Password.length() == 0 || Password.length() >= this->PASSWORD_SIZE)
		return -1;

	if(Email.length() >= this->EMAIL_SIZE)
		return -1;

	if (Description.length() >= this->DESCRIPTION_SIZE)
		return -1;

	nlohmann::json card;

	card["title"] = Title;
    card["password"] = Password;
	card["email"] = Email;
	card["description"] = Description;

	this->data.push_back(card);

	return 1;
}

int PassSafer::EditCard(const QString &indexQ, const QString &TitleQ, const QString &PasswordQ, const QString &EmailQ,  const QString &DescriptionQ)
{
    int index = indexQ.toInt();
    std::string Title = TitleQ.toStdString();
    std::string Password = PasswordQ.toStdString();
    std::string Email = EmailQ.toStdString();
    std::string Description = DescriptionQ.toStdString();

	if (index < 0 || index > this->data.size())
		return -1;

	if (Title.length() == 0 || Title.length() >= this->TITLE_SIZE)
		return -1;

	if (Password.length() == 0 || Password.length() >= this->PASSWORD_SIZE)
		return -1;

	if (Email.length() >= this->EMAIL_SIZE)
		return -1;

	if (Description.length() >= this->DESCRIPTION_SIZE)
		return -1;

	this->data[index]["title"] = Title;
    this->data[index]["password"] = Password;
	this->data[index]["email"] = Email;
	this->data[index]["description"] = Description;

	return 1;
}

int PassSafer::DeleteCard(const QString &indexQ)
{
    int index = indexQ.toInt();
	if (index < 0 || index > this->data.size())
		return -1;

	try {
		this->data.erase(index);
	}
	catch(nlohmann::json::out_of_range &ex)
	{
		return -1;
	}
	catch (nlohmann::json::type_error)
	{
		return -1;
	}

	return 1;
}

bool PassSafer::DeleteAllCards()
{
	try {
		this->data.clear();
		return true;
	}
	catch (nlohmann::json::other_error)
	{
		return false;
	}
}

QStringList PassSafer::GetCardInfo(unsigned int index)
{
    QStringList lst;
	if (index < 0 || index > this->data.size())
        return QStringList("");

    lst << QString::number(index);
    lst <<  QString::fromStdString( this->data[index]["title"] );
    lst <<  QString::fromStdString( this->data[index]["password"] );
    lst <<  QString::fromStdString( this->data[index]["email"] );
    lst <<  QString::fromStdString( this->data[index]["description"] );

    return lst;
}

unsigned short PassSafer::getCardCount()
{
	return this->data.size();
}

bool PassSafer::CreateMasterPassword(const QString &passwordQ)
{
    std::string password = passwordQ.toStdString();
	if (this->isFileExist == true)
		return false;

	this->key = password;

	this->isSavingToFile = true;


    return true;
}

bool PassSafer::EnterMasterPassword(const QString& passwordQ)
{
    std::string password = passwordQ.toStdString();
	if (this->isFileExist == false)
		return false;

	this->key = password;

	if (this->readDataFromFile(this->FILENAME) == 1)
	{
		this->isSavingToFile = true;
		return true;
	}
	else
	{
		return false;
	}
}

bool PassSafer::ChangeMasterPassword(const QString& new_passwordQ)
{
    std::string new_password = new_passwordQ.toStdString();
	if (PassSafer::IsPasswordStrong(new_password))
	{
		this->key = new_password;
		return true;
	}
	else
	{
		return false;
	}
}

QString PassSafer::GeneratePassword(const int length)
{
	std::string ret_password = "";


	while (PassSafer::IsPasswordStrong(ret_password) == false)
	{
		char* buffer = new char[length + 1];
		memset(buffer, '\0', length + 1);

		for (int i = 0; i < length; i++)
			buffer[i] = char(rand() % 93 + 33);

		ret_password = buffer;
		delete[] buffer;
	}
	
    return QString::fromStdString( ret_password );
}

bool PassSafer::IsPasswordStrong(const char* password)
{
    if (strlen(password) <= 10)
        return false;
	
    bool upper_case = std::regex_search(password, std::regex("[A-Z]+"));
    bool lower_case = std::regex_search(password, std::regex("[a-z]+"));
    bool number_case = std::regex_search(password, std::regex("[0-9]+"));
    bool special_char = std::regex_search(password, std::regex("[!\"#$ % &'()*+,-./:;<=>?@[\\]^_`{|}~]+"));

    return int(upper_case + lower_case + number_case + special_char) >= 3;
}

bool PassSafer::IsPasswordStrong(const std::string& password)
{
    if (password.length() <= 10)
        return false;

    bool upper_case = std::regex_search(password, std::regex("[A-Z]+"));
    bool lower_case = std::regex_search(password, std::regex("[a-z]+"));
    bool number_case = std::regex_search(password, std::regex("[0-9]+"));
    bool special_char = std::regex_search(password, std::regex("[!\"#$ % &'()*+,-./:;<=>?@[\\]^_`{|}~]+"));

    return int(upper_case + lower_case + number_case + special_char) >= 3;
}

bool PassSafer::IsPasswordStrong(const QString &passwordQ)
{
    std::string password = passwordQ.toStdString();

    if (password.length() <= 10)
        return false;

    bool upper_case = std::regex_search(password, std::regex("[A-Z]+"));
    bool lower_case = std::regex_search(password, std::regex("[a-z]+"));
    bool number_case = std::regex_search(password, std::regex("[0-9]+"));
    bool special_char = std::regex_search(password, std::regex("[!\"#$ % &'()*+,-./:;<=>?@[\\]^_`{|}~]+"));

    return int(upper_case + lower_case + number_case + special_char) >= 3;
}

bool PassSafer::isFileGood()
{
	return this->isFileExist;
}


