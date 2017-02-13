import * as React from "react";
import { render } from "react-dom";
import { get } from "axios";
import * as m from "moment";

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
        let time: string;
        if (this.state.last_udated === "never") {
            time = "never";
        } else {
            time = m(new Date(this.state.last_udated)).fromNow();
        }
        return <div>
            <nav className="pt-navbar pt-dark">
                <div className="pt-navbar-group pt-align-left" >
                    <div className="pt-navbar-heading">Fox.Build Member Stats</div>
                </div>
                <div className="pt-navbar-group pt-align-right">
                    <a className="pt-button pt-minimal pt-icon-home" href="//fox.build">
                        Home
                        </a>
                    <a className="pt-button pt-minimal pt-icon-chat" href="//foxbuild.slack.com">
                        Chat
                        </a>
                    <span className="pt-navbar-divider"></span>
                    <button className="pt-button pt-minimal pt-icon-user"
                        onClick={() => alert("Ouch!")}></button>
                </div>
            </nav>
            <hr />
            <div className="flex-row">
                <div className="flex-col">
                    <h3>Updated {time}</h3>
                    <ul>
                        {this.people()}
                    </ul>
                </div>
                <div className="flex-col">
                    <img src={CAM_URL} />
                </div>
            </div>
        </div >;
    }
}

render(<Who />, document.getElementById("wow"));
