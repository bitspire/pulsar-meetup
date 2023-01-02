package ca.bitspire.meetup.pulsar;

public class ChatMessage {

    private String from;
    private String message;
    private long timestamp;

    public ChatMessage() {}

    public ChatMessage(String from, String message) {
        this.from = from;
        this.message = message;
        this.timestamp = System.currentTimeMillis();
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "ChatMessage [from=" + from + ", message=" + message + ", timestamp=" + timestamp + "]";
    }
}
