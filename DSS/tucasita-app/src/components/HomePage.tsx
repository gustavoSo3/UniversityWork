import React from 'react';
import styles from './HomePage.module.scss';

interface Props {
  title: string;
  bannerUrl: string;
  description: string;
}

const HomePage: React.FC<Props> = ({ title, bannerUrl, description }) => {
  return (
    <div className={styles.homepage}>
      <h1>{title}</h1>
      <img src={bannerUrl} alt="Banner" className={styles.banner} />
      <p>{description}</p>
    </div>
  );
};

export default HomePage;
