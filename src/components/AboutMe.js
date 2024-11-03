import about from '../assets/about.jpg';

function AboutMe() {
    return (
        <div className="2xl:h-112 flex flex-col p-4 2xl:p-0 2xl:flex-row justify-center items-center">
            <div className="h-5/6 w-auto sm:w-4/5 2xl:w-1/4 flex flex-col justify-center">
                <h2 className="m-2 text-2xl font-semibold">About Me</h2>
                <p className="m-2 text-sm text-justify">Hi! I'm Luis, a Cloud Engineer dedicated to using AWS to foster innovation and efficiency. I design and implement resilient cloud infrastructure, particularly for the gaming sector, optimizing performance and boosting reliability.</p>
                <p className="m-2 text-sm text-justify">With a solid foundation in DevOps and Cloud Architecture, I automate processes and monitor systems for seamless operations. I excel in dynamic settings, consistently adopting the latest AWS technologies to address complex challenges.</p>
                <p className="m-2 text-sm text-justify">My skills encompass AWS services, serverless architecture, and integrating security into cloud solutions. I aim to deliver impactful results while empowering teams through mentorship and leadership.</p>
            </div>
            <div className="h-5/6 w-auto sm:w-4/5 2xl:w-1/4 flex flex-col justify-center items-center">
                <img src={about} className="w-80 rounded" alt="" />
            </div>
        </div>
    );
}

export default AboutMe;