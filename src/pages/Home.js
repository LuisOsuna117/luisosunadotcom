import AboutMe from "../components/AboutMe"
import Certifications from "../components/Certifications";
import Divider from "../components/Divider";
import Education from "../components/Education";
import Footer from "../components/Footer";
import Hero from "../components/Hero";
import WorkHistory from "../components/WorkHistory";

function Home() {
    return (
        <div>
            <Hero />
            <AboutMe />
            <Divider title="Work History"/>
            <WorkHistory/>
            <Divider title="Certifications"/>
            <Certifications/>
            <Divider title="Education"/>
            <Education/>
            <Footer/>
        </div>
    );
}

export default Home;