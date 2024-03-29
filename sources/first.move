module 0x1::SocialNetwork {
    use std::debug;
    use std::vector;

    struct Friends has store, key, drop{
        people: vector<Person>
    }
    struct Person has store, key, drop, copy {
        name: vector <u8>,
        age: u8,
    }

    public fun create_friend(myFriend:Person, friends: &mut Friends) : Person {
        let newFriend = Person{
            name:myFriend.name,
            age: myFriend.age ,           
        };
        add_friend(newFriend, friends);
        return newFriend
    }

    public fun add_friend(_person: Person, friends: &mut Friends) {
        vector::push_back(&mut friends.people, _person)
    }

// test code...
    #[test]
    fun test_create_friend() {
        let richard = Person {
            name: b"Richard",
            age: 31,
        };
        let myFriend = Friends {
            people: (vector[richard])
        };
        let createdFriend = create_friend(richard, &mut myFriend);
        debug::print(&createdFriend);
        assert!(createdFriend.name == b"Richard" , 0);
    }
}
