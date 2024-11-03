import Item from "./Item";
import EducationData from "../data/education.json"

function Education() {
    return (
        <div className="divide-y divide-black/87 flex flex-col items-center p-4">
            {EducationData.map((item) => (
                <Item key={item.id} img={item.image} title={item.title} dates={item.dates} desc={item.description} />
            ))}
        </div>
    );
}

export default Education;