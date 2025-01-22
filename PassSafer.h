#ifndef PassSafer_header
#define PassSafer_header

#include <nlohmann/json.hpp>

#include <cryptopp/cryptlib.h>
#include <cryptopp/aes.h>
#include <cryptopp/modes.h>
#include <cryptopp/hex.h>
#include <cryptopp/filters.h>
#include <cryptopp/sha.h>
#include <cryptopp/pwdbased.h>

#include <fstream>
#include <filesystem>

#include <string>
#include <cstring>

#include <regex>

#include <QObject>
#include <QString>
#include <QStringList>

using namespace CryptoPP;

class PassSafer : public QObject
{
    Q_OBJECT

private:
	nlohmann::json data;

    const char* FILENAME = "data";
	bool isFileExist = false;
	bool isSavingToFile = false;


	std::string key;

	const unsigned int SIZE_DATA_STR = 100000;

	const unsigned int MAX_CARDS_COUNT = 10;

    const unsigned int TITLE_SIZE = 150;
	const unsigned int URL_SIZE = 250;
	const unsigned int EMAIL_SIZE = 150;
	const unsigned int USERNAME_SIZE = 150;
	const unsigned int PASSWORD_SIZE = 250;
    const unsigned int DESCRIPTION_SIZE = 450;

	//		File func
	int readDataFromFile(const char* filename);
    int writeDataToFile(const char* filename="data");

	//		AES Encryption functions
    // bool EncryptAES(const unsigned char *plaintext, int plaintext_lin, unsigned char *ciphertext, int &ciphertext_len);
    // bool DecryptAES(const unsigned char *ciphertext, int ciphertext_len, unsigned char *plaintext, int &plaintext_len);

    bool EncryptAES(const char * plaintext, size_t len, std::string &ciphertext);
    bool DecryptAES(const char * ciphertext, size_t len ,std::string& plaintext);

public:
    explicit PassSafer(QObject *parent = nullptr);
	~PassSafer();


	//		Card func
    Q_INVOKABLE int CreateCard(const QString &TitleQ, const QString &PasswordQ, const QString &EmailQ = "",  const QString &DescriptionQ = "");
    Q_INVOKABLE int EditCard(const QString &indexQ, const QString &TitleQ, const QString &PasswordQ, const QString &EmailQ = "",  const QString &DescriptionQ = "");
    Q_INVOKABLE int DeleteCard(const QString &index);
    Q_INVOKABLE bool DeleteAllCards();

    Q_INVOKABLE QStringList GetCardInfo(unsigned int index);

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

    //  Files functions
    Q_INVOKABLE bool SaveToFile();


};


#endif
