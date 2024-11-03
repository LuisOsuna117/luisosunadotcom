import Item from "./Item";
import CertificationsData from "../data/certifications.json"

function Certifications() {
    return (
        <div className="divide-y divide-black/87 flex flex-col items-center p-4">
            {CertificationsData.map((item) => (
                <Item key={item.id} img={item.image} title={item.title} dates={item.dates} desc={item.description} />
            ))}
        </div>
    );
}

export default Certifications;