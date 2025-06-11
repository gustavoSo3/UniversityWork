'use client'

import React, { useState } from 'react';
import UserDetails from '@/components/UserDetails';
import {UserFormData} from '@/components/UserDetails';
import UserValidation from '@/components/UserValidation';
import UserTypeSelection from '@/components/UserTypeSelection';
import Navbar from '@/components/Navbar';

enum RegistrationState {
  SELECTING_USER_TYPE,
  FILLING_DETAILS,
  VALIDATING_USER,
  COMPLETED
}

const RegistrationPage: React.FC = () => {
  const [registrationState, setRegistrationState] = useState<RegistrationState>(
    RegistrationState.SELECTING_USER_TYPE
  );
  const [userType, setUserType] = useState<'Agent' | 'Buyer' | null>(null);
  const [userDetails, setUserDetails] = useState<UserFormData>({
    fullName: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
    address: '',
    agencyName: '',
    areaOfOperation: '',
  });
  const [errorMessage, setErrorMessage] = useState<string | null>(null);


  const handleUserTypeSelection = (type: 'Agent' | 'Buyer') => {
    setUserType(type);
    setRegistrationState(RegistrationState.FILLING_DETAILS);
  };

  const handleDetailsSubmission = () => {
    setRegistrationState(RegistrationState.VALIDATING_USER);
  };

  const handleUserDetailsChange = (updatedDetails: UserFormData) => {
    setUserDetails(updatedDetails);
  };

  const handleValidation = () => {
    setErrorMessage(null);
    setRegistrationState(RegistrationState.COMPLETED);
  };

  return (
    <>
      <Navbar />
      <div className="flex flex-col items-center mt-20">
        {registrationState === RegistrationState.SELECTING_USER_TYPE && (
          <>
            <UserTypeSelection onUserTypeSelect={handleUserTypeSelection} />
          </>
        )}

        {registrationState === RegistrationState.FILLING_DETAILS && userType && (
          <>
            <UserDetails
              userType={userType}
              userDetails={userDetails}
              onDetailsChange={handleUserDetailsChange}
              onSubmit={handleDetailsSubmission}
            />
            <button
              className="bg-gray-200 hover:bg-gray-300 px-4 py-2 mt-4 rounded cursor-pointer transition"
              onClick={() => setRegistrationState(RegistrationState.SELECTING_USER_TYPE)}>
              Go Back to User Type Selection
            </button>
          </>
        )}

        {registrationState === RegistrationState.VALIDATING_USER && (
          <>
            {errorMessage && <p className="text-red-500">{errorMessage}</p>}
            <UserValidation
              password={userDetails?.password}
              confirmPassword={userDetails?.confirmPassword}
              onValidated={handleValidation}
              onValidationError={setErrorMessage}
            />
            <button
              className="bg-gray-200 hover:bg-gray-300 px-4 py-2 mt-4 rounded cursor-pointer transition"
              onClick={() => setRegistrationState(RegistrationState.FILLING_DETAILS)}>
              Go Back to User Details
            </button>
          </>
        )}

        {registrationState === RegistrationState.COMPLETED && (
          <div>
            <p>Thank you for registering! You will receive a validation email shortly.</p>
          </div>
        )}
      </div>
    </>
  );
};

export default RegistrationPage;
