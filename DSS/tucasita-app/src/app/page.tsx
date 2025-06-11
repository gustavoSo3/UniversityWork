import Navbar from '@/components/Navbar';
import HomePage from '@/components/HomePage';

function MyApp() {
  return (
    <>
      <Navbar />
      <div>
        <HomePage
          title="Welcome to Micasita!"
          bannerUrl="Casa_Madrigal.png"
          description="This is a brief description of what the site or page is about."
        />
      </div>
    </>
  );
}

export default MyApp;
