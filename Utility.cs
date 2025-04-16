using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Text;
using System.Threading;
using System.Web;
using System.Drawing;

namespace Online_Exam_System
{
    public static class Utility
    {
        public static byte[] HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                return sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            }
        }

        public static bool VerifyPassword(string enteredPassword, byte[] storedPasswordHash)
        {
            byte[] enteredPasswordHash = HashPassword(enteredPassword);
            return enteredPasswordHash.SequenceEqual(storedPasswordHash);
        }

        public static bool IsValidEmail(string email)
        {
            string emailPattern = @"^[^\s@]+@[^\s@]+\.[^\s@]+$";
            return Regex.IsMatch(email, emailPattern);
        }

        public static bool IsValidPassword(string password)
        {
            string passwordPattern = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
            return Regex.IsMatch(password, passwordPattern);
        }
  
        public static string UsernameGenarator()
        {
            const string lowercaseChars = "abcdefghijklmnopqrstuvwxyz";
            const string uppercaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

            StringBuilder charSet = new StringBuilder();
            charSet.Append(lowercaseChars);
            charSet.Append(uppercaseChars);


            int length = 10;
            Random random = new Random();
            StringBuilder username = new StringBuilder(length);

            for (int i = 0; i < length; i++)
            {
                int index = random.Next(charSet.Length);
                username.Append(charSet[index]);
            }
            return username.ToString();
        }
        public static string PasswordGenarator()
        {
            const string lowercaseChars = "abcdefghijklmnopqrstuvwxyz";
            const string uppercaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            const string digitChars = "0123456789";
            const string specialChars = "!@#$%^&*";

            StringBuilder charSet = new StringBuilder();
            charSet.Append(lowercaseChars);
            charSet.Append(uppercaseChars);
            charSet.Append(digitChars);
            charSet.Append(specialChars);

            int length = 10;
            Random random = new Random();
            StringBuilder password = new StringBuilder(length);

            for (int i = 0; i < length; i++)
            {
                int index = random.Next(charSet.Length);
                password.Append(charSet[index]);
            }
            return password.ToString();
        }

        public static string GenerateOtp()
        {
            Random random = new Random();
            int otp = random.Next(100000, 1000000); // Generates a number between 100000 and 999999
            return otp.ToString();
        }
        public static byte[] ConvertImageToByteArray(string filePath)
        {
            return File.ReadAllBytes(filePath);
        }
        public static Image ConvertByteArrayToImage(byte[] imageData)
        {
            using (var ms = new MemoryStream(imageData))
            {
                return Image.FromStream(ms);
            }
        }

    }

}

