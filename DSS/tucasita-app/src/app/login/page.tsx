'use client'

import React from 'react';
import LoginForm from '@/components/LoginForm';
import Navbar from '@/components/Navbar';

const LoginPage: React.FC = () => {
  const handleLoginSubmit = (username: string, password: string) => {
    // Here, you'd typically handle the login logic, like sending a request to your backend.
  };

  return (
    <>
      <Navbar />
      <div className="flex flex-col items-center mt-20">
        <h1>Input your username and password</h1>
        <LoginForm onSubmit={handleLoginSubmit} />
      </div>
    </>
  );
};

export default LoginPage;
