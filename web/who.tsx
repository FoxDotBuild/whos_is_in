import * as React from "react";
import { render } from "react-dom";
import { get } from "axios";

const CAM_URL = "http://loco.freeshell.org/foxbuild2.jpg";
const PPL_URL = "http://api.myjson.com/bins/190kzb";

interface State {
    last_udated: string;
    who_is_here: string[];
    hp: { [name: string]: number; };
    loading: boolean;
}

class Who extends React.Component<{}, State> {
    constructor() {
        super();
        this.state = {
            last_udated: "never",
            who_is_here: [],
            hp: {},
            loading: true
        };
    }
    componentDidMount() {
        get<State>(PPL_URL).then(r => this.setState({ loading: false, ...r.data }));
    }

    people() {
        let { who_is_here } = this.state;
        if (this.state.loading) {
            return <li> Loading... </li>;
        };

        if (who_is_here.length > 0) {
            return this
                .state
                .who_is_here
                .map((p, i) => {
                    return <li key={i}> ({this.state.hp[p] || 0} XP) {p}</li>;
                });
        } else {
            return <li> No one is here. </li>;
        }
    }

    render() {
        return <div>
            <h2>LIVE MEMBER LIST</h2>
            <h3>Updated {this.state.last_udated}</h3>
            <ul>
                {this.people()}
            </ul>
            <img src={CAM_URL} />
        </div>;
    }
}

render(<Who />, document.getElementById("wow"));
