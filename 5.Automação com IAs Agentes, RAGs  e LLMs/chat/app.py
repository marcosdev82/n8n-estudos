import streamlit as st
import requests
import uuid


CHAT_URL = "http://localhost:5678/webhook/dac91511-896d-4cbf-8d7a-d696ff551a37/chat"


st.markdown(
    "<h1 style='text-align: center;'>SmartHome Pro X100</h1>",
    unsafe_allow_html=True
)

st.markdown(
    "<h3 style='text-align: center;'>Assistente Inteligente do Manual do Produto</h3>",
    unsafe_allow_html=True
)

st.markdown(
    "<p style='text-align: center;'>"
    "Tire dúvidas sobre instalação, configuração, uso e manutenção "
    "com base exclusivamente no manual oficial."
    "</p>",
    unsafe_allow_html=True
)

if "session_id" not in st.session_state:
    st.session_state.session_id = str(uuid.uuid4())


if "messages" not in st.session_state:
    st.session_state.messages = []


def ask_question(question: str) -> str:
    payload = {
        "chatInput": question,
        "sessionId": st.session_state.session_id,
        "loadPreviousSession": True
    }

    response = requests.post(CHAT_URL, json=payload, timeout=120)

    if response.status_code != 200:
        return f"Erro {response.status_code}: {response.text}"

    data = response.json()

    return data.get("output", "Não foi possível obter resposta.")


for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])


prompt = st.chat_input("Digite sua pergunta sobre o SmartHome Pro X100:")

if prompt:

    st.session_state.messages.append({
        "role": "user",
        "content": prompt
    })

    with st.chat_message("user"):
        st.markdown(prompt)

    answer = ask_question(prompt)

    st.session_state.messages.append({
        "role": "assistant",
        "content": answer
    })

    with st.chat_message("assistant"):
        st.markdown(answer)
