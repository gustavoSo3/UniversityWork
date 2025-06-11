'use client'

import { useEffect } from 'react';
import { useSearchParams } from 'next/navigation';
import sha256 from 'crypto-js/sha256';

interface UserValidationProps {
  password: string;
  confirmPassword: string;
  onValidated: () => void;
  onValidationError: (error: string) => void;
}

const UserValidation: React.FC<UserValidationProps> = ({
  password,
  confirmPassword,
  onValidated,
  onValidationError,
}) => {
  const searchParams = useSearchParams();

  useEffect(() => {
    if (searchParams?.get('validated') === 'true') {
      onValidated();
    } else if (password !== confirmPassword) {
      onValidationError("Passwords don't match.");
    } else if (sha256(password).toString() !== sha256(confirmPassword).toString()) {
      onValidationError("Hashed passwords don't match.");
    } else {
      onValidated();
    }
  }, [password, confirmPassword, searchParams]);

  return null;
};

export default UserValidation;
