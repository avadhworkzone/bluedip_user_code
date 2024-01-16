/// REGULAR EXPRESSION
class RegularExpression {
  /// TextField Enter Pattern Expression
  static String emailPattern = r"([a-zA-Z0-9_@.])";
  static String passwordPattern = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String alphabetPattern = r"[a-zA-Z]";
  static String alphabetSpacePattern = r"[a-zA-Z. ]";
  static String alphabetDigitSpacePattern = r"[a-zA-Z0-9#&$%_@.'?+ ]";
  static String alphabetDigitSpacePattern_ = r"[a-zA-Z0-9#&$%_@.'?+/ ]";
  static String alphabetDigitsPattern = r"[a-zA-Z0-9 ]";
  static String alphabetWithoutSpaceDigitsPattern = r"[a-zA-Z0-9]";
  static String alphabetDigitsSpacePlusPattern = r"[a-zA-Z0-9+ ]";
  static String alphabetDigitsSpecialSymbolPattern = r"[a-zA-Z0-9#&$%_@., ]";
  static String alphabetDigitsDashPattern = r"[a-zA-Z0-9- ]";
  static String addressValidationPattern = r"[a-zA-Z0-9-@#&* ]";
  static String digitsPattern = r"[0-9]";
  static String pricePattern = r'^\d+\.?\d*';
  static String leadingZero = r'^[1-9][0-9]*$';
  static String ifscCodePattern = r'^[A-Z]{4}0[A-Z0-9]{6}$';
  static String alphabetWithSpacePattern = r'^[A-Za-z]+[A-Za-z ]*$';
  // static String address = r"^[A-Za-z0-9\s\.,#-]+$";
  static String address = r'^[\w\s\d#,.-]+$';

  /// Validation Expression Pattern
  static String emailValidationPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String passwordValidPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static String linkValidationPattern =
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
}

/// ------------------------------------------------------------------- ///
/// VALIDATION MESSAGE WITH
class ValidationMsg {
  static String isRequired = "is required";
  static String phoneIsRequired = "Phone Number is required";
  static String emailIsRequired = "Email is required";
  static String somethingWentToWrong = "Something went Wrong";
  static String pleaseEnterValidEmail = "Please Enter Valid Email";
  static String passwordLength = 'Must Be More Than 6 Char';
  static String mobileNoLength = 'Phone number must be 10 Digit';
  static String mobileNoLengthMoreThan10 =
      'Phone number cannot be more than 10 character';
  static String passwordInValid = 'Password Invalid';
  static String invalidURl = 'Invalid URL';
  static String fisrtName = 'Fill Name';
  static String ifscValid = 'Enter Valid Ifsc Code';
  static String account = 'Enter Valid account number';
  static String bankName = 'Enter Valid Name';
  static String name = 'Enter Your Name';
}

/// ------------------------------------------------------------------- ///
/// VALIDATION METHOD
class ValidationMethod {
  /// EMAIL VALIDATION METHOD
  static String? validateUserName(value) {
    bool regex =
        RegExp(RegularExpression.emailValidationPattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.emailIsRequired;
    } else if (regex == false) {
      return ValidationMsg.pleaseEnterValidEmail;
    }
    return null;
  }

  /// ifsc code
  static String? ifscCode(value) {
    bool regex = RegExp(RegularExpression.ifscCodePattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.isRequired;
    } else if (regex == false) {
      return ValidationMsg.ifscValid;
    } else if (value as String == r'^[A-Z]{4}0[A-Z0-9]{6}$') {
      return ValidationMsg.ifscValid;
    }
    return null;
  }

  /// bank and branch name
  static String? bankAndBranchName(value) {
    bool regex =
        RegExp(RegularExpression.alphabetWithSpacePattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.isRequired;
    } else if (regex == false) {
      return ValidationMsg.bankName;
    }
    return null;
  }

  /// account code
  static String? account(value) {
    bool regex = RegExp(RegularExpression.digitsPattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.isRequired;
    } else if (regex == false) {
      return ValidationMsg.account;
    }
    return null;
  }

  /// PASSWORD VALIDATION METHOD
  static String? validatePassword(value) {
    RegExp regex = RegExp(RegularExpression.passwordValidPattern);
    if ((value as String).isEmpty) {
      return ValidationMsg.isRequired;
    } else if (value.length <= 6) {
      return ValidationMsg.passwordLength;
    } else if (regex == false) {
      return ValidationMsg.passwordInValid;
    }

    return null;
  }

  /// LINK VALIDATION METHOD
  static String? validateLink(value) {
    bool regex =
        RegExp(RegularExpression.linkValidationPattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.isRequired;
    } else if (regex == false) {
      return ValidationMsg.invalidURl;
    }

    return null;
  }

  /// First Name Last Name
  static String? firstLastName(value) {
    bool regex = RegExp(RegularExpression.alphabetSpacePattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.isRequired;
    } else if (regex == false) {
      return ValidationMsg.name;
    }

    return null;
  }

  /// MOBILE VALIDATION METHOD
  static String? validatePhoneNo(value) {
    if ((value as String).isEmpty) {
      return ValidationMsg.phoneIsRequired;
    } else if (value.length < 10) {
      return ValidationMsg.mobileNoLength;
    } else if (value.length > 10) {
      return ValidationMsg.mobileNoLengthMoreThan10;
    }
    return null;
  }

  /// IS REQUIRED VALIDATION METHOD  (COMMON METHOD)
  static String? validateIsRequired(value) {
    if ((value as String).isEmpty) {
      return ValidationMsg.isRequired;
    }
    return null;
  }
}
