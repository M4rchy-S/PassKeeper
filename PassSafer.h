#ifndef PassSafer_header
#define PassSafer_header

#include <nlohmann/json.hpp>

#include <openssl/evp.h>
#include <openssl/rand.h>

#include <fstream>
#include <filesystem>

#include <string>
#include <cstring>

#include <regex>

#include <QObject>
#include <QString>

class PassSafer : public QObject
{
    Q_OBJECT

private:
	nlohmann::json data;

	const char* FILENAME = "data.json";
	bool isFileExist = false;
	bool isSavingToFile = false;

	const unsigned char iv[35] = "VynsKJ9VddfOAz0Xu8lSHhbvnkExzpY3";
	std::string key;

	const unsigned int SIZE_DATA_STR = 100000;

	const unsigned int MAX_CARDS_COUNT = 10;

	const unsigned int TITLE_SIZE = 100;
	const unsigned int URL_SIZE = 250;
	const unsigned int EMAIL_SIZE = 150;
	const unsigned int USERNAME_SIZE = 150;
	const unsigned int PASSWORD_SIZE = 250;
	const unsigned int DESCRIPTION_SIZE = 2048;

	//		File func
	int readDataFromFile(const char* filename);
	int writeDataToFile(const char* filename);

	//		AES Encryption functions
	bool EncryptAES(const unsigned char *plaintext, int plaintext_lin, unsigned char *ciphertext, int &ciphertext_len);
	bool DecryptAES(const unsigned char *ciphertext, int ciphertext_len, unsigned char *plaintext, int &plaintext_len);

public:
    explicit PassSafer(QObject *parent = nullptr);
	~PassSafer();


	//		Card func
    Q_INVOKABLE int CreateCard(const std::string &Title, const std::string &Password, const std::string &URL = "", const std::string &Email = "", const std::string &UserName = "", const std::string &Description = "");
    Q_INVOKABLE int EditCard(unsigned int index, const std::string &Title, const std::string &Password, const std::string &URL = "", const std::string &Email = "", const std::string &UserName = "", const std::string &Description = "");
    Q_INVOKABLE int DeleteCard(unsigned int index);
    Q_INVOKABLE bool DeleteAllCards();

	nlohmann::json GetCardInfo(unsigned int index);

	//		Utility func
    Q_INVOKABLE unsigned short getCardCount();
    Q_INVOKABLE bool isFileGood();

	//		Password func
    Q_INVOKABLE bool CreateMasterPassword(const QString &passwordQ);
    Q_INVOKABLE bool EnterMasterPassword(const QString &passwordQ);
    Q_INVOKABLE bool ChangeMasterPassword(const QString &new_passwordQ);


	//		Utility static func
    Q_INVOKABLE static QString GeneratePassword(const int length=20);
    Q_INVOKABLE static bool IsPasswordStrong(const char *password);
    Q_INVOKABLE static bool IsPasswordStrong(const std::string &password);
    Q_INVOKABLE static bool IsPasswordStrong(const QString &passwordQ);


};


#endif
