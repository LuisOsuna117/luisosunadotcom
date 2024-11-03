import Item from "./Item";
import WorkHistoryData from "../data/work-history.json"

function WorkHistory() {
    return (
        <div className="divide-y divide-black/87 flex flex-col items-center p-4">
            {WorkHistoryData.map((item) => (
                <Item key={item.id} img={item.image} title={item.title} dates={item.dates} desc={item.description} />
            ))}
        </div>
    );
}

export default WorkHistory;